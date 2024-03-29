//
//  logout.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//

import Foundation

func logout() {
    UserDefaults.standard.removeObject(forKey: "savedUsername")
    UserDefaults.standard.removeObject(forKey: "savedPassword")
    UserDefaults.standard.removeObject(forKey: "favourites")
    UserDefaults.standard.removeObject(forKey: "purchases")

    UserDefaults.standard.synchronize()
}
