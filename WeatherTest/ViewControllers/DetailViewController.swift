//
//  DetailViewController.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var realFeelTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    weak var data: Weather? 

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        self.title = data?.name
        summaryLabel.text = data?.summary
        temperatureLabel.text = data?.currentTemperature
        realFeelTemperatureLabel.text = data?.feelsLike
        minTemperatureLabel.text = data?.minTemperature
        maxTemperatureLabel.text = data?.maxTemperature
        pressureLabel.text = data?.pressure
        windSpeedLabel.text = data?.windSpeed
    }

}
