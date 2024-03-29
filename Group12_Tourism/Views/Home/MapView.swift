//
//  MapView.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/13/24.
//

import SwiftUI

import MapKit

struct MapView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @EnvironmentObject var events : EventsUI
//    @State private var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.64253, longitude: -79.38201), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var searchLocation : CLLocation?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.64253, longitude: -79.38201), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    var body: some View {
        VStack{
//            Map(coordinateRegion: self.$coordinateRegion, interactionModes: .all, showsUserLocation: true)
            
            //check for specific permission and enable/disable features
            
            if (searchLocation != nil){
//                Map(coordinateRegion: self.$region, interactionModes: .all)
                
                MyMap(location: searchLocation!)
                
            }else if (self.locationHelper.currentLocation != nil){
                MyMap(location: self.locationHelper.currentLocation! )
            } else {
                Text(" Obtaining locations")
            }
        }
        .onAppear(){
            //check/request for permissions
            self.locationHelper.checkPermission()
            
            if (self.locationHelper.currentLocation != nil){

                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.locationHelper.currentLocation!.coordinate.latitude, longitude: self.locationHelper.currentLocation!.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
        }
    }//body
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}


struct MyMap : UIViewRepresentable{
    @EnvironmentObject var events : EventsUI
    
    typealias UIViewType = MKMapView
    private var location : CLLocation
    @EnvironmentObject var locationHelper : LocationHelper
    let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
    
    init( location : CLLocation){
        self.location = location
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        
        sourceCoordinates = location.coordinate
        
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true
        
        map.setRegion(region, animated: true)
        
        return map
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        var annotations : [MKAnnotation] = []
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        sourceCoordinates = location.coordinate

        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        for event in events.events {
            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: event.venue.location.lat!, longitude: event.venue.location.lon!)
            mapAnnotation.title = event.title
            annotations.append(mapAnnotation)
        }
        
        uiView.setRegion(region, animated: true)
        uiView.addAnnotations(annotations)
    }
    
}
