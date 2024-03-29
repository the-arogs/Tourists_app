//
//  ActivityDetailsMap.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/13/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct EventMapView: View {
    @EnvironmentObject var locationHelper: LocationHelper
    var event : EventAPI
    
    var body: some View {
        VStack{
            EventMap(location: CLLocation(
                latitude: event.venue.location.lat! as Double,
               longitude: event.venue.location.lon! as Double), event: event)

            
        }.onAppear(){
            self.locationHelper.checkPermission()
        }
    }
}


struct EventMap : UIViewRepresentable{
    
    typealias UIViewType = MKMapView
    var event : EventAPI
    private var location: CLLocation


    @EnvironmentObject var locationHelper : LocationHelper
    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    init(location: CLLocation, event: EventAPI){
        self.location = location
        self.event = event
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
        
        let sourceCoordinates : CLLocationCoordinate2D
        let region : MKCoordinateRegion
        
        if true {

          if uiView.annotations.count > 0 {

            uiView.removeAnnotation(uiView.annotations.last!)

          }

          sourceCoordinates = location.coordinate

          region = MKCoordinateRegion(center: sourceCoordinates, span: span)

          let mapAnnotation = MKPointAnnotation()
          mapAnnotation.coordinate = sourceCoordinates
            mapAnnotation.title = "\(event.venue.name!)\n\(event.venue.address!)"

          uiView.setRegion(region, animated: true)
          uiView.addAnnotation(mapAnnotation)

        }
        
    }
    
}

