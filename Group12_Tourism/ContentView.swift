//
//  ContentView.swift
//  Group12_Tourism
//
//  Created by Allen Christian on 2024-02-14.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    @State private var showingLogoutAlert = false
    
    var body: some View {
        VStack {
            loginForm()
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("")
        
        .navigationBarItems(trailing:
            NavigationLink(destination: EmptyView()) {
                Image(systemName: "line.horizontal.3") // Hamburger menu icon
                    .foregroundColor(.blue)
                    .onTapGesture {
                    
                        showingLogoutAlert = true
                    }
            }
        )
        .alert(isPresented: $showingLogoutAlert) {
            Alert(title: Text("Menu"), message: nil, primaryButton: .default(Text("Logout"), action: {
                logout()
                
            }), secondaryButton: .default(Text("Favorites"), action: {
                // Handle favorites action
            }))
        }

    }
    
}

#Preview {
    ContentView()
}
