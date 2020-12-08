//
//  WeatherTableViewCell.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    var data: Weather? {
        didSet {
            if data != nil {
                setupData()
            }
        }
    }

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cityNameLabel.text = ""
        temperatureLabel.text = ""
    }
    
    private func setupData() {
        cityNameLabel.text = data?.name
        temperatureLabel.text = data?.shortTemperature
    }

}
