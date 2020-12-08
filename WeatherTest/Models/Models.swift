//
//  CitiesData.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
}

struct WeatherContainer: Codable {
    let list: [Weather]
}

class Weather: Codable {
    let name: String
    private let temperature: Temperature
    private let description: [Summary]
    private let wind: Wind

    private enum CodingKeys : String, CodingKey {
        case name, temperature = "main", description = "weather", wind
    }

    var shortTemperature: String {
        return String(temperature.temp) + " F"
    }

    var currentTemperature: String {
        return "Current temperature: \(String(temperature.temp)) F"
    }

    var maxTemperature: String {
        return "Max temperature: \(String(temperature.max)) F"
    }

    var minTemperature: String {
        return "Min temperature: \(String(temperature.min)) F"
    }

    var feelsLike: String {
        return "Feels like \(String(temperature.feels)) F"
    }

    var pressure: String {
        return "Pressure: \(String(temperature.pressure))"
    }

    var windSpeed: String {
        return "Wind speed: \(String(wind.speed))"
    }

    var summary: String {
        if description.count == 0 {return ""}
        var result = description[0].main + ": " + description[0].description
        description.forEach{ item in
            result += "\n"
            result += "\(item.main): \(item.description)"
        }
        return result
    }
}

struct Summary: Codable {
    let main: String
    let description: String
}

struct Temperature: Codable {
    let temp: Double
    let feels: Double
    let min: Double
    let max: Double
    let pressure: Double

    private enum CodingKeys : String, CodingKey {
        case temp, feels = "feels_like", min = "temp_min", max = "temp_max", pressure
    }
}

struct Wind: Codable {
    let speed: Float
}

class CitiesContainer {

    var data: [City] = []
    var fullData: [City] = []

    init() {
        if let localData = self.readDataFile() {
            self.parse(jsonData: localData)
        }
    }

    func getDataForInitialRequest() -> String {
        var result = String(data[0].id)
        for index in 1..<data.count {
            result += ","
            result += String(data[index].id)
        }
        return result
    }

    private func readDataFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "city.list",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }

    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([City].self,
                                                       from: jsonData)
            data = Array(decodedData[0...1])
            fullData = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }

}
