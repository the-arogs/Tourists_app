//
//  DataManager.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    // For demonstration purposes
    var activities: [Activity] = Activity.sampleActivities
    
    private init() {}
}

