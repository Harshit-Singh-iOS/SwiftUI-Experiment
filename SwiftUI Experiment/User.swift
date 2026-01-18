//
//  User.swift
//  SwiftUI Experiment
//
//  Created by Harshit on 1/17/26.
//

import Foundation

@Observable
class ExposedUser {
    var users: [User]
    
    init(users: [User]) {
        self.users = users
    }
}

@Observable
class User {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
