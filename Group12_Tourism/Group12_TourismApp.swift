//
//  Group12_TourismApp.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI
import FirebaseCore
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Group12_TourismApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let locationHelper = LocationHelper()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationHelper)
        }
    }
}
