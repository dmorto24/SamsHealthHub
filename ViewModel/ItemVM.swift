import Foundation
import Firebase
import FirebaseFirestore

class ItemViewModel: ObservableObject {
    @Published var list = [ItemModel]()
    
    func getItems() {
        let db = Firestore.firestore()
        db.collection("Items").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.list = snapshot.documents.map { document in
                            let data = document.data()
                            let id = document.documentID
                            let name = data["name"] as? String ?? ""
                            let description = data["description"] as? String ?? ""
                            return ItemModel(id: id, name: name, description: description)
                        }
                    }
                }
            } else {
                print("Error fetching Documents")
            }
        }
    }
    
    func getItemDetails(item: ItemModel, completion: @escaping (Information?) -> Void) {
        let db = Firestore.firestore()
        let itemDetailsCollection = db.collection("Information")
        itemDetailsCollection.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching item details: \(error)")
                completion(nil)
                return
            }
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()

                    if let iidRef = data["iid"] as? DocumentReference {
                        let iid = iidRef.documentID

                        if iid == item.id {
                            let calories = data["calories"] as? Int ?? 0
                            let carbs = data["carbs"] as? Int ?? 0
                            let cholesterol = data["cholesterol"] as? Int ?? 0
                            let fat = data["fat"] as? Int ?? 0
                            let protein = data["protein"] as? Int ?? 0
                            let sodium = data["sodium"] as? Int ?? 0

                            let carbCals = carbs * 4
                            let fatCals = fat * 9
                            let proteinCals = protein * 4
                            var calorieResult: String
                            var carbResult: String
                            var cholesterolResult: String
                            var fatResult: String
                            var proteinResult: String
                            var sodiumResult: String
                            
                            if Double(calories) <= 300 {
                                calorieResult = "Low"
                            } else {
                                calorieResult = "High"
                            }

                            if (Double(carbCals) / Double(calories)) <= 0.65 {
                                carbResult = "Low"
                            } else {
                                carbResult = "High"
                            }

                            if cholesterol <= 200 {
                                cholesterolResult = "Low"
                            } else {
                                cholesterolResult = "High"
                            }

                            if (Double(fatCals) / Double(calories)) <= 0.30 {
                                fatResult = "Low"
                            } else {
                                fatResult = "High"
                            }

                            if (Double(proteinCals) / Double(calories)) <= 0.40 {
                                proteinResult = "Low"
                            } else {
                                proteinResult = "High"
                            }

                            if sodium <= 350 {
                                sodiumResult = "Low"
                            } else {
                                sodiumResult = "High"
                            }

                            let itemInformation = Information(id: document.documentID, iid: iid, calories: calories, calorieThresh: calorieResult, carbs: carbs, carbThresh: carbResult, cholesterol: cholesterol, cholesterolThresh: cholesterolResult, fat: fat, fatThresh: fatResult, protein: protein, proteinThresh: proteinResult, sodium: sodium, sodiumThresh: sodiumResult)

                            completion(itemInformation)
                            return
                        }
                    } else {
                        print("iid is nil or not a DocumentReference")
                    }
                }
            }

            print("No document found for the specified item")
            completion(nil)
        }
    }

    func filteredItems(for searchText: String) -> [ItemModel] {
        if searchText.isEmpty {
            return list
        } else {
            return list.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
