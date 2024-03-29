//
//  Events.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/13/24.
//

import Foundation

class Events : Codable, ObservableObject {
    var events : [EventAPI] = []
}

// MARK: - Event
struct EventAPI: Codable, Identifiable {
    var type: String 
    var id: Int
    var title: String
    var url : String
    var datetime_utc : String
    var performers: [Performer]
    var venue: Venue
    var stats: EventStats
}

struct Performer : Codable , Identifiable{
    var id: Int
    var name : String
    var image : String
}

// MARK: - EventStats
struct EventStats: Codable {
    var listing_count: Int?
    var average_price: Int?
}


// MARK: - Venue
struct Venue: Codable {
    var state: String?
    var postal_code : String?
    var name: String?
    var address: String?
    var country: String?
    var city: String?
    var display_location: String?
    var location : Location
}

struct Location: Codable {
    var lat : Double?
    var lon : Double?
}
