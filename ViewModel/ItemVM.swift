//
//  ItemVM.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/19/24.
//

import Foundation
import Firebase
import FirebaseFirestore

class ItemViewModel: ObservableObject {
    @Published var list = [ItemModel]()
    
    func getItems(){
        //reference db
        let db = Firestore.firestore()
        //read documents
        db.collection("Items").getDocuments { snapshot, error in
            //check for errors
            if error == nil{
                //no errors
                if let snapshot = snapshot{
                    DispatchQueue.main.async{
                        //get all documents and create items
                        self.list = snapshot.documents.map { d in
                            return ItemModel(id: d.documentID,
                                             name: d["name"] as? String ?? "",
                                             description: d["description"] as? String ?? "")
                        }
                    }
                }
            }
            else{
                print("Error fetching Documents")
            }
        }
    }
}
