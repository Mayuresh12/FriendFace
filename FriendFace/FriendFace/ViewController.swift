//
//  ViewController.swift
//  FriendFace
//
//  Created by Mayuresh Rao on 8/21/20.
//  Copyright © 2020 Mayuresh Rao. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var friends = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let downloadFriends = try decoder.decode([Friend].self, from: data)
                DispatchQueue.main.async {
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
    
}

