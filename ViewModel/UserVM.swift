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
    
    func setUser(id: String,email: String,fname: String, lname: String, password: String, phone: Int) {
        currentUser = User(id: id,email: email,fname: fname, lname: lname, password:password,phone:phone )
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
                        self.currentUser = User(id: id, email: email, fname: fname, lname: lname, password: "", phone: phone)
                        completion(true)                        
                    }
                }
        }
    }
