//
//  ViewController.swift
//  FriendFace
//
//  Created by Mayuresh Rao on 8/21/20.
//  Copyright © 2020 Mayuresh Rao. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    let dataSource = FriendDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }

        dataSource.fetch("https://www.hackingwithswift.com/samples/friendface.json")
        tableView.dataSource = dataSource

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        navigationItem.searchController = search
    }

    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filterText = searchController.searchBar.text
    }

}
