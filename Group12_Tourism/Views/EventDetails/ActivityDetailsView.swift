//
//  ActivityDetailsView.swift
//  Tourist_Group12
//
//  Created by Arogs on 2/13/24.
//

import SwiftUI


struct ActivityDetailsView: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper

    var event : EventAPI
    @State private var rating :Int = 1
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var linkSelection : Int? = nil
    @State private var favouritesList : [Activity] = []
    @State private var showAlert : Bool = false
    @State private var alertTitle : String = ""
    @State private var stepperForPurchase : Double = 1.0
    @State private var purchasesList : [Purchase] = []
    @State private var showPurchaseAlert : Bool = false
    @State private var alertTitlePurchase : String = ""
    @State private var alertMessagePurchase : String = ""
    @EnvironmentObject var locationHelper : LocationHelper


    
    var body: some View {
        NavigationLink(destination: loginForm().navigationBarBackButtonHidden(true), tag: 2, selection: self.$linkSelection){}
//        ScrollView (.horizontal, showsIndicators: false){
//            HStack(alignment: .top, spacing: 0){
//                ForEach(self.activity.images, id: \.self) {
//                    image in
//                    Image(image).resizable().aspectRatio(contentMode: .fill)
//                }
//            }//HStack
//            .frame(height: 200 )
//            Spacer()
//        }
        //.frame(height: 200 )
//        Spacer()
        
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                Text(event.title).font(.title)
                Text(event.datetime_utc).font(.callout)
                Spacer().frame(height: 20)

                Text("Performing Act(s):")
                ForEach (event.performers) {
                    performer in
                    Text(performer.name)
                    AsyncImage(url: URL(string: "\(performer.image)"))
                }
                
                Spacer().frame(height: 40)

                if event.stats.average_price != nil {
                    Text("Price: $\(event.stats.average_price!)")
                }
    //            Text(String(format: "$%.2f", event.stats.average_price!)).bold()
    //            HStack{
    //                Text("Tourists Rating:");
    //                StarRating(rating: $rating)
    //            }
    //            Spacer().frame(height: 20)
    //            VStack(alignment: .center){
    //                Text("Buy Tickets").font(.title3)
    //
    //                HStack {
    //
    //                    Text("\(String(format: "%.0f", stepperForPurchase)) Ticket(s)\n")
    //                    Stepper("", value: $stepperForPurchase, in: 1...10).transformEffect(.init(scaleX: 0.7, y: 0.7))
    //                }
    //                Text("Price: \(String(format: "$%.0f", stepperForPurchase * Double(event.stats.average_price!)))")
    //                Button(action: {
    //                    addPurchase(currActivity: activity, quantity: stepperForPurchase)
    //                }) {
    //                    Text("Buy now")
    //                }
    //                .buttonStyle(.borderedProminent)
    //                .controlSize(.regular)
    //                .alert(isPresented: self.$showPurchaseAlert){
    //                    Alert(title: Text("\(self.alertTitlePurchase)"), message: Text("\(self.alertMessagePurchase)"), dismissButton: .default(Text("Dismiss")))
    //                }
    //            }
    //                .font(.system(size: 14))
                
                Spacer().frame(height: 40)
                Text("Location: \(event.venue.name! + ", " + event.venue.address! + ", " + event.venue.state! + ", " + event.venue.postal_code!)")
    //            let numberString = activity.phoneNumber
    //            HStack{
    //                Text("Contact: ")
    //
    //                Button(action: {
    //                    viewModel.callNumber(phoneNumber: numberString)
    //                   }) {
    //                   Text(numberString)
    //                }
    //
    //            }
    //                Spacer()
                
    //            Spacer()
            }//VStack MAin
    //        .position(x:120, y:250)
    //        .frame(maxWidth: 280)
            .padding()
            VStack{
                EventMapView(event: event).frame(width: 300, height: 200)
            }
        }
//        .padding()
        Spacer()
        HStack (spacing: 50) {
            ShareLink(item: "\(event.url)\n"){
                Label("Share", systemImage: "square.and.arrow.up").foregroundColor(.appStyle)
            }
            Button{
                addToFavourite(currEvent: event)
                print("Event saved ")
            }label: {
                Image(systemName: "heart"); Text("Attend")
            }
            .alert(isPresented: self.$showAlert){
                Alert(title: Text("\(self.alertTitle)"), message: nil, dismissButton: .default(Text("Dismiss")))
            }
            .foregroundColor(.appStyle)
        }
        
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
    
    func addToFavourite(currEvent: EventAPI) {
        for event in self.fireDBHelper.dbEventsList {
            if event.title == currEvent.title {
                self.alertTitle = "Event already added"
                self.showAlert = true
                return
            }
        }
        print(#function , "attempting to save event")
        DispatchQueue.main.async{
            self.fireDBHelper.insertEvent(newEvent: currEvent)
            self.alertTitle = "Successfully added"
            self.showAlert = true
            print(#function, "Saved event")
        }
        
    }
    
    func addPurchase(currActivity: Activity, quantity : Double) {
        for purchase in purchasesList {
            if (purchase.activity.id == currActivity.id ) {
                purchase.quantity += quantity
                self.alertTitlePurchase = "Purchased!"
                self.alertMessagePurchase = "\(String(format: "%.0f", stepperForPurchase)) more Ticket(s): \(String(format: "$%.2f", currActivity.price * quantity))"
                savePurcchasesListToUD(purchasesList: purchasesList)
                resetPurchaseInput()
                self.showPurchaseAlert = true
                return
            }
        }
        purchasesList.append(Purchase(activity: currActivity, quantity: quantity))
        savePurcchasesListToUD(purchasesList: purchasesList)
        self.alertTitlePurchase = "Purchased!"
        self.alertMessagePurchase = "\(String(format: "%.0f", stepperForPurchase)) Ticket(s): \(String(format: "$%.2f", currActivity.price * quantity))"
        self.showPurchaseAlert = true
        resetPurchaseInput()
    }
    func resetPurchaseInput () {
        self.stepperForPurchase = 1.00
    }
}

//#Preview {
//    ActivityDetailsView(event: EventAPI(), viewModel: ViewModel())
//}
