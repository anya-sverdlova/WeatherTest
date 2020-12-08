//
//  NetworkManager.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import Foundation

class NetworkManager {

    var APIKey = "595a2e390867ac32cbcf12f7f6f422ad"

    func getWeather(data: String, completion: @escaping([Weather]) -> ()) {
        let queryItems = [URLQueryItem(name: "id", value: data), URLQueryItem(name: "appid", value: APIKey)]
        var urlComps = URLComponents(string: "https://api.openweathermap.org/data/2.5/group")!
        urlComps.queryItems = queryItems
        guard let result = urlComps.url else {return}

        let task = URLSession.shared.dataTask(with: result) {(data, response, error) in
            if data != nil {
                do {
                    let result = try JSONDecoder().decode(WeatherContainer.self, from: data!)

                    completion(result.list)
                } catch {
                    print("error: ", error)
                }
            }

            if error != nil {
                print(error!.localizedDescription)
            }
        }

        task.resume()
    }
}
