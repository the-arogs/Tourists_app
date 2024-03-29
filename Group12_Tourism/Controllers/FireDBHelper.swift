//
//  FireDBHelper.swift
//  Group12_Tourism
//
//  Created by Arogs on 3/14/24.
//

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var dbEventsList = [EventInDB]()
    
    private let db : Firestore
    private static var shared : FireDBHelper?
    private let COLLECTION_EVENTS : String = "Events"
    private let FIELD_NAME : String = "Title"
    private let FIELD_URL : String = "URL"
    private let FIELD_DATE : String = "Date"
    private let FIELD_VENUE : String = "Venue"

    
    init(db : Firestore){
        self.db = db
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(db: Firestore.firestore())
        }
        
        return shared!
    }
    
    
    func insertEvent(newEvent : EventAPI){
        let newEventToDB = EventInDB(title: newEvent.title, url: newEvent.url, datetime_utc: newEvent.datetime_utc, location: newEvent.venue.name!)
        do{
            try self.db
                .collection(COLLECTION_EVENTS)
                .addDocument(from: newEventToDB)
        }catch let err as NSError{
            print(#function, "Unable to add document to firestore : \(err)")
        }
    }
    
    func getAllEvents(){

            
            self.db.collection(COLLECTION_EVENTS)
                .addSnapshotListener({ (querySnapshot, error) in
                    
                    guard let snapshot = querySnapshot else{
                        print(#function, "Unable to retrieve data from firestore : \(error)")
                        return
                    }
                    
                    snapshot.documentChanges.forEach{ (docChange) in
                        
                        do{
                            
                            var event : EventInDB = try docChange.document.data(as: EventInDB.self)
                            event.id = docChange.document.documentID
                            
                            let matchedIndex = self.dbEventsList.firstIndex(where: {($0.id?.elementsEqual(docChange.document.documentID))!})
                            
                            switch(docChange.type){
                            case .added:
                                print(#function, "Document added : \(docChange.document.documentID)")
                                self.dbEventsList.append(event)
                            case .modified:
                                //replace existing object with updated one
                                print(#function, "Document updated : \(docChange.document.documentID)")
                                if (matchedIndex != nil){
                                    self.dbEventsList[matchedIndex!] = event
                                }
                            case .removed:
                                //remove object from index in eventList
                                print(#function, "Document removed : \(docChange.document.documentID)")
                                if (matchedIndex != nil){
                                    self.dbEventsList.remove(at: matchedIndex!)
                                }
                            }
                            
                        }catch let err as NSError{
                            print(#function, "Unable to convert document into Swift object : \(err)")
                        }
                        
                    }//forEach
                })//addSnapshotListener
        
    }//getAllBooks
    
    func deleteEvent(eventToDelete : EventInDB){
        self.db.collection(COLLECTION_EVENTS)
            .document(eventToDelete.id!)
            .delete{error in
                if let err = error{
                    print(#function, "Unable to delete document : \(err)")
                }else{
                    print(#function, "successfully deleted : \(eventToDelete.title)")
                }
            }
    }
    
    func deleteAll () {
        print(#function, "deleting all events")
        for event in self.dbEventsList {
            deleteEvent(eventToDelete: event)
        }
        print(#function, "successfully deleted all events")
    }
    
}
