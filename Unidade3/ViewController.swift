//
//  ViewController.swift
//  Unidade3
//
//  Created by Davi Oliveira on 2024-04-14.
//

import UIKit

class ViewController: UITableViewController {

    let coreDataManager = CoreDataManager()

    var issues: [Issue]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }

    private func fetchData() {
        issues = try? coreDataManager.context.fetch(Issue.fetchRequest())
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        issues?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let issue = issues?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = issue.name
        cell.contentConfiguration = content
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let issue = issues?[indexPath.item] else { return }
            coreDataManager.context.delete(issue)
            fetchData()
        }
    }


}

