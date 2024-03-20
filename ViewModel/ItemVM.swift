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
                        self.list = snapshot.documents.map { document in
                                                let data = document.data()
                                                let id = document.documentID
                                                let name = data["name"] as? String ?? ""
                                                let description = data["description"] as? String ?? ""
                                                return ItemModel(id: id, name: name, description: description)
                                            }
                    }
                }
            }
            else{
                print("Error fetching Documents")
            }
        }
    }
    func getItemDetails(item: ItemModel, completion: @escaping (Information?) -> Void) {
        // Reference to the collection where the specific information about the item is stored
        let db = Firestore.firestore()
        let itemDetailsCollection = db.collection("Information")
        
        // Fetch all documents from the Information collection
        itemDetailsCollection.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching item details: \(error)")
                completion(nil) // Call completion handler with nil if there's an error
                return
            }
            
            // Filter documents to find the relevant one based on the iid field
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                
                    if let iidRef = data["iid"] as? DocumentReference {
                        let iid = iidRef.documentID
                        
                        // Compare the documentID of the iidRef with the item.id
                        if iid == item.id {
                            // Document found, parse the data and create Information object
                            let calories = data["calories"] as? Int ?? 0
                            let carbs = data["carbs"] as? Int ?? 0
                            let cholesterol = data["cholesterol"] as? Int ?? 0
                            let fat = data["fat"] as? Int ?? 0
                            let protein = data["protein"] as? Int ?? 0
                            let sodium = data["sodium"] as? Int ?? 0
                            
                            let itemInformation = Information(id: document.documentID, iid: iid, calories: calories, carbs: carbs, cholesterol: cholesterol, fat: fat, protein: protein, sodium: sodium)
                            
                            completion(itemInformation) // Call completion handler with the fetched itemInformation
                            return
                        }
                    } else {
                        print("iid is nil or not a DocumentReference")
                    }
                }
            }
            
            // No document found for the specified item
            print("No document found for the specified item")
            completion(nil) // Call completion handler with nil if no document found
        }
    }






        func filteredItems(for searchText: String) -> [ItemModel] {
            if searchText.isEmpty {
                return list // Return all items if search text is empty
            } else {
                return list.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
        }
        
    }
