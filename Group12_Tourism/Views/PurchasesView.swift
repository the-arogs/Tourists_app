//
//  PurchasesView.swift
//  Group12_Tourism
//
//  Created by Arogs on 2/16/24.
//

import SwiftUI

struct PurchasesView: View {
    @State private var purchasesList : [Purchase] = []
    @State private var linkSelection : Int? = nil

    var body: some View {
        NavigationStack {
            NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
            List {
                if !self.purchasesList.isEmpty {
                    ForEach(self.purchasesList) {
                        purchase in
                        HStack(spacing: 15) {
                            Image(purchase.activity.images[0])
                                        .resizable()
                                        .frame(width: 75, height: 75) // Adjust size as needed
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(purchase.activity.name)
                                        Text(String(format: "%.0f Tickets", purchase.quantity))
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                        }//Hstack
                                .padding()
                    }
                }else {
                    Text("Buy a ticket")
                }
            }
            .onAppear(){
                if let data = UserDefaults.standard.data(forKey: "purchases") {
                    do {
                        let decoder = JSONDecoder()
                        let purchasedActivites = try decoder.decode([Purchase].self, from: data)
                        self.purchasesList = purchasedActivites
                    } catch {
                        print("Unable to get purchases")
                    }
                }
            }
            
            .background(.white)
                .navigationTitle("Purchase History")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
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
        }
    }
}

#Preview {
    PurchasesView()
}
