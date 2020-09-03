//
//  Friends.swift
//  FriendFace
//
//  Created by Mayuresh Rao on 9/2/20.
//  Copyright © 2020 Mayuresh Rao. All rights reserved.
//

import Foundation

struct Friend: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
}
