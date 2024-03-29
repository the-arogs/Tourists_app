//
//  Favourites.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/15/24.
//
import Foundation
import SwiftUI

struct Favourites: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper

    @State private var favouritesList : [EventInDB] = []
    @State private var linkSelection : Int? = nil
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
            
            
            List {
                if !self.fireDBHelper.dbEventsList.isEmpty {
                    ForEach(self.fireDBHelper.dbEventsList) {
                        event in
                        HStack(spacing: 15) {
                            //            Image(activity.images[0])
                            //            //Image(activity.imageName)
                            //                        .resizable()
                            //                        .frame(width: 75, height: 75) // Adjust size as needed
                            //
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(event.title)")
                                Text("\(event.location)")
                                //                        Text(String(format: "$%/Person", event.stats.average_price!))
                                    .foregroundColor(.secondary)
                            }//Vstack
                            Spacer()
                        }//HStack
                    }//ForEach
                    .onDelete(perform: {
                        indexSet in
                        for index in indexSet {
                            self.fireDBHelper.deleteEvent(eventToDelete: self.fireDBHelper.dbEventsList[index])
                            self.fireDBHelper.dbEventsList.remove(at: index)
                        }
                    })//onDelete
                }else {
                    Text("You do not have Favourites yet")
                }
            }//List
            .background(.white)
                .navigationTitle("Events Attending")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Button{
                            self.fireDBHelper.deleteAll()
                            } label:{
                                Text("Clear List")
                            }
                        
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
            }//toolbar
        }//NavStack
    }//body
}

#Preview {
    Favourites()
}
