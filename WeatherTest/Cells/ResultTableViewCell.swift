//
//  ResultTableViewCell.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    var data: City? {
        didSet {
            if data != nil {
                setupData()
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        label.text = ""
    }

    private func setupData() {
        label.text = data?.name
    }
}
