//
//  ListView.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/13/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var events : EventsUI
    @EnvironmentObject var fireDBHelper : FireDBHelper
    
    var body: some View {
        List(events.events) { event in
            NavigationLink(destination: ActivityDetailsView(event: event).environmentObject(fireDBHelper)) {
                ActivityRow(event: event)
            }
        }
    }
}

//#Preview {
//    ListView()
//}
