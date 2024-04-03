//
//  UserVM.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/21/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var currentUser: User?
    @State private var isLoggedIn = false
    @State private var errorMessage: String?
    @Published var list = [Goal]()
    
    func setUser(id: String,email: String,fname: String, lname: String, password: String, phone: Int) {
        self.currentUser = User(id: id,email: email,fname: fname, lname: lname, password:password,phone:phone)
        self.objectWillChange.send()
    }
    func signup(email: String, fname: String, lname: String, password: String, phone: String){
        // Get a reference to the Firestore database
        let db = Firestore.firestore()
        // Specify the collection where you want to add the document
        let collectionRef = db.collection("User")

        // Define the data you want to store in the document
        let data: [String: Any] = [
            "email": email,
            "fname": fname,
            "lname": lname,
            "password":password,
            "phone":phone
        ]

        // Add the data to the collection using the addDocument method
        collectionRef.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        // Check if the user exists in Firestore with the provided email and password
        Firestore.firestore().collection("User")
            .whereField("email", isEqualTo: email)
            .getDocuments { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Error signing in: \(error.localizedDescription)"
                    completion(false)
                } else {
                    guard let document = querySnapshot?.documents.first else {
                        self.errorMessage = "Invalid credentials"
                        completion(false)
                        return
                    }
                    let userData = document.data()
                    let id = document.documentID
                    let email = userData["email"] as? String ?? ""
                    let fname = userData["fname"] as? String ?? ""
                    let lname = userData["lname"] as? String ?? ""
                    let phone = userData["phone"] as? Int ?? 0
                    let user = User(id: id, email: email, fname: fname, lname: lname, password: "", phone: phone)
                    self.currentUser = user
                    completion(true)
                }
            }
    }
    func getGoals(for user: User, completion: @escaping (Goal?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userID = user.id

        let userDocRef = db.collection("User").document(userID)
        
        db.collection("Goal").whereField("aid", isEqualTo: userDocRef).limit(to: 1).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching Documents: \(error.localizedDescription)")
                completion(nil, error)
                return
            }

            if let snapshot = snapshot, !snapshot.isEmpty {
                let document = snapshot.documents[0]
                let data = document.data()
                let id = document.documentID
                let aid = data["aid"] as? DocumentReference ?? userDocRef
                let cal = data["calories"] as? String ?? ""
                let carbs = data["carbs"] as? String ?? ""
                let chol = data["cholesterol"] as? String ?? ""
                let fat = data["fat"] as? String ?? ""
                let protein = data["protein"] as? String ?? ""
                let sodium = data["sodium"] as? String ?? ""
                
                let goal = Goal(id: id, aid: aid, calories: cal, carbs: carbs, cholesterol: chol, fat: fat, protein: protein, sodium: sodium)
                completion(goal, nil)
            } else {
                // No goal found
                completion(nil, nil)
            }
        }
    }

}
