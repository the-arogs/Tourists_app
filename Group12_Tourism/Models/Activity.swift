//
//  Activity.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import Foundation
class Activity: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var price: Double
    var images: [String]
    var hostedBy: String
    var phoneNumber: String
    var rating: Int
    
    init(name: String, description: String, price: Double, hostedBy: String, images: [String], phoneNumber: String, rating: Int ) {
        self.name = name
        self.description = description
        self.price = price
        self.hostedBy = hostedBy
        self.images = images
        self.phoneNumber = phoneNumber
        self.rating = rating
    }
    
    // For demonstration purposes
        static var sampleActivities: [Activity] = [
            Activity(name: "Toronto City Tour", description: "Explore the city landmarks", price: 50.0, hostedBy: "Mark Miller", images: ["torontoCity1", "torontoCity3", "torontoCity2", "torontoCity4"], phoneNumber : "14377876658", rating: 3),
            Activity(name: "Downtown Photography Walk", description: "Elevate your Toronto experience with the Toronto Downtown Photo Walk", price: 70.0, hostedBy: "Tej Parker", images: ["photographyWalk1", "photographyWalk2", "photograpghyWalk3"], phoneNumber : "16755257784", rating: 4),
            Activity(name: "Food Tasting", description: "Food Tasting", price: 40.0, hostedBy: "Jay Jay", images: ["foodTasting1", "foodTasting2", "foodTasting3"], phoneNumber : "13452253674", rating: 3)
        ]
    
    init() {
        self.name = "name"
        self.description = "description"
        self.price = 250.50
        self.hostedBy = "hostedBy"
        self.images = ["image1", "image2", "image3"]
        self.phoneNumber = "111-222-3334"
        self.rating = 4
    }
    
    
}
