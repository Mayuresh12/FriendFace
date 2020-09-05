//
//  ViewController.swift
//  FriendFace
//
//  Created by Mayuresh Rao on 8/21/20.
//  Copyright © 2020 Mayuresh Rao. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {


    var friends = [Friend]()
    var filteredFreinds = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        navigationItem.searchController = search
        
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let downloadFriends = try decoder.decode([Friend].self, from: data)
                DispatchQueue.main.async {
                    self.filteredFreinds = downloadFriends
                    self.friends = downloadFriends
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friends.map{ $0.name}.joined(separator: ",")
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         return filteredFreinds.count
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 0 {
            filteredFreinds = friends.filter {
                $0.name.contains(text)
                    || $0.company.contains(text)
                    || $0.address.contains(text)
            }
        } else {
            filteredFreinds = friends
        }

        tableView.reloadData()
    }
    
}

