//
//  User.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import Foundation
class User :ObservableObject{
    var email: String
    var password: String
    var favorites: [Activity]
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.favorites = []
    }
}
