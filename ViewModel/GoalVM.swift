//
//  GoalVM.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/19/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class GoalViewModel: ObservableObject {
    @Published var list = [Goal]()
    @StateObject var userViewModel = UserViewModel() // Create an instance of UserViewModel
    
    func getGoals() {
        guard let currentUser = userViewModel.currentUser else {
            // Handle the case when currentUser is nil (e.g., user not logged in)
            return
        }
        func getGoals(){
            let db = Firestore.firestore()
            
            db.collection("Goal").getDocuments{ snapshot, error in
                //check for errors
                if error == nil{
                    //no errors
                    if let snapshot = snapshot{
                        DispatchQueue.main.async{
                            //get all documents and create goals
                            self.list = snapshot.documents.map { document in
                                let data = document.data()
                                let id = document.documentID
                                let aid = data["aid"] as? DocumentReference
                                let cal = data["calories"] as? String ?? ""
                                let carbs = data["carbs"] as? String ?? ""
                                let chol = data["cholesterol"] as? String ?? ""
                                let fat = data["fat"] as? String ?? ""
                                let protein = data["protein"] as? String ?? ""
                                let sodium = data["sodium"] as? String ?? ""
                                return Goal(id: id, aid: aid!, calories: cal, carbs: carbs, cholesterol: chol, fat: fat, protein: protein, sodium: sodium)
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
}
