//
//  DataManager.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import Foundation

class DataManager {

    var cityData = CitiesContainer()
    var weatherData: [Weather] = []
    var count: Int {
        return weatherData.count
    }

    func getInitialData() -> String {
        return cityData.getDataForInitialRequest()
    }

    func result(for searchString: String) -> [City] {
        return cityData.fullData.filter({$0.name.hasPrefix(searchString)})
    }

    func append(_ city: City) {
        cityData.data.append(city)
    }
}
