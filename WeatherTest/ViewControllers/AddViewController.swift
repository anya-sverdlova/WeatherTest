//
//  AddViewController.swift
//  WeatherTest
//
//  Created by Anna Tropman on 29.11.2020.
//

import UIKit

final class AddViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    weak var dataManager: DataManager?
    var result: [City] = []
    private var searchString: String = "" {
        didSet {
            result = dataManager?.result(for: searchString) ?? []
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let result = textField.text else {return}
        searchString = result
        tableView.reloadData()
    }
}

extension AddViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell", for: indexPath) as? ResultTableViewCell else {
            return UITableViewCell()
        }
        cell.data = result[indexPath.row]
        return cell
    }

    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    private func tableView(tableView: (UITableView?), commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: (NSIndexPath?)) {

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let add = UIContextualAction(style: .normal, title: "Add") {[unowned self] (action, view, completion) in
            self.dataManager?.append(self.result[indexPath.row])
            self.result.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let config = UISwipeActionsConfiguration(actions: [add])
        config.performsFirstActionWithFullSwipe = false

            return config
        }
}
