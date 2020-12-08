//
//  MainViewController.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataManager = DataManager()
    private var networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        networkManager.getWeather(data: dataManager.getInitialData()) { [unowned self] result in

            DispatchQueue.main.async {
                self.dataManager.weatherData = result
                self.tableView.reloadData()
            }
        }
    }

    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        self.navigationItem.rightBarButtonItem = addButton
    }

    @objc func addCity() {
        let storyboard = UIStoryboard(name: "AddViewController", bundle: nil)
        guard let add = storyboard.instantiateViewController(withIdentifier: "addViewController") as? AddViewController else {return}
        add.dataManager = self.dataManager
        self.navigationController?.pushViewController(add, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.data = dataManager.weatherData[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WeatherTableViewCell else {return}
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        guard let detail = storyboard.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController else {return}
        detail.data = cell.data
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
