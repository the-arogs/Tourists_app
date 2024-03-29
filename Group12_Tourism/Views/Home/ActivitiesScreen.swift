//
//  ActivitiesScreen.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI
import CoreLocation

struct ActivitiesScreen: View {
    private let fireDBHelper = FireDBHelper.getInstance()
    private var events : EventsUI = EventsUI()
    @State private var linkSelection : Int? = nil
    @StateObject private var dataManager = DataManager.shared
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var searchCityFromUI : String = ""
    @State private var searchLocation : CLLocation? = nil
    @State private var eventsAPI : Events = Events()
    

    var body: some View {
        NavigationStack {
            NavigationLink(destination: Favourites().environmentObject(fireDBHelper), tag: 3, selection: self.$linkSelection){}
            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
//            NavigationLink(destination: PurchasesView(), tag: 1, selection: self.$linkSelection){}
            HStack {
                TextField("Search by location", text: self.$searchCityFromUI)
                    .modifier(AppTextFieldModifier())
                Button(action: {
                    doGeocoding(address: self.searchCityFromUI)
                }
                       , label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                }).frame()
            }.padding()
            TabView {
                ListView().environmentObject(events).environmentObject(fireDBHelper).tabItem{
                    Image(systemName: "list.bullet.clipboard")
                    Text("List")
                }
                
                MapView(searchLocation: self.searchLocation).environmentObject(events).environmentObject(fireDBHelper).tabItem{
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            }
//            List(dataManager.activities) { activity in
//                NavigationLink(destination: ActivityDetailsView(activity: activity)) {
//                    ActivityRow(activity: activity)
//                }
//            }
            .navigationTitle("Things To Do").navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Button{
                                self.linkSelection = 3
                            } label:{
                                Text("Favourites")
                            }
//                        Button{
//                                self.linkSelection = 1
//                            } label:{
//                                Text("Purchases")
//                            }
                        
                        Button{
                                logout()
                                self.linkSelection = 2
                            } label:{
                                Text("Logout")
                            }
                            
                        }//Menu
                        label: {
                            Image(systemName: "list.bullet")
                        }
                    }
            }
        }.onAppear(){
            locationHelper.checkPermission()
            if locationHelper.currentLocation == nil {
                locationHelper.currentLocation = CLLocation(latitude: 45.5019, longitude: -73.5674)
            }
            loadDataFromAPI(coordinates: locationHelper.currentLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 45.5019, longitude: -73.5674))
                
            DispatchQueue.main.async{
                self.fireDBHelper.getAllEvents()

            }
                
        }
    }
    private func doGeocoding(address: String){
        print(#function, "Performing geocoding on address: \(address)")
        
        self.locationHelper.doForwardGeocoding(address: address, completionHandler: {
                (coordinates, error) in
            
            if (error == nil && coordinates != nil){
                
                self.searchLocation = coordinates
                loadDataFromAPI(coordinates: self.searchLocation!.coordinate)
                print("coordinates found")
            }else{
                print("Unable to get coordinates")
            }
        })
        
        
    }
    
    func loadDataFromAPI( coordinates: CLLocationCoordinate2D) {
        print("Getting data from API")
        
        let websiteAddress:String = "https://api.seatgeek.com/2/events?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&client_id=NDAzNzc1MTR8MTcxMDM0MjY1MS4zNzUyMzA2"
        
        guard let apiURL = URL(string: websiteAddress) else {
            print("ERROR: Cannot convert api address to an URL object")
            return
        }
        
        let request = URLRequest(url:apiURL)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data:Data?, response, error:Error?) in

   
            if let error = error {
                print("ERROR: Network error: \(error)")
                return
            }
            

            if let jsonData = data {
                print("data retreived")
                if let decodedResponse = try? JSONDecoder().decode(Events.self, from:jsonData) {
                    // if conversion successful, then output it to the console
                    DispatchQueue.main.async {
                        self.eventsAPI = decodedResponse
                        self.events.events = self.eventsAPI.events
                    }
                }
                else {
                    print("ERROR: Error converting data to JSON")
                }
            }
            else {
                print("ERROR: Did not receive data from the API")
            }
        }
        task.resume()
        
        
    }

    
    
}

struct ActivityRow: View {
    var event : EventAPI
    
    var body: some View {
        HStack(spacing: 15) {
//            Image(activity.images[0])
//            //Image(activity.imageName)
//                        .resizable()
//                        .frame(width: 75, height: 75) // Adjust size as needed
//            
                    VStack(alignment: .leading, spacing: 4) {
                        Text(event.title)
                        Text(event.venue.name!)
//                        Text(String(format: "$%/Person", event.stats.average_price!))
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
        
        
            }
}



//#Preview {
//    ActivitiesScreen()
//}
