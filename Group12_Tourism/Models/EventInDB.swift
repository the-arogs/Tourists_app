//
//  EventsDB.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/14/24.
//

import Foundation

import FirebaseFirestoreSwift

struct EventInDB: Codable, Hashable, Identifiable {
    @DocumentID var id : String? = UUID().uuidString
    var title: String
    var url : String
    var datetime_utc : String
    var location : String
    
    init(title: String, url: String, datetime_utc: String, location: String) {
        self.title = title
        self.url = url
        self.datetime_utc = datetime_utc
        self.location = location
    }
}
