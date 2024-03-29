//
//  Purchase.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/16/24.
//

import Foundation

class Purchase : Codable, Identifiable {
    var activity: Activity
    var quantity: Double
    
    
    init(activity: Activity, quantity: Double) {
        self.activity = activity
        self.quantity = quantity
        
    }
}
