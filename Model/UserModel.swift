//
//  UserModel.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/21/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct User: Identifiable{
    var id: String
    var email: String
    var fname: String
    var lname: String
    var password: String
    var phone: Int
}
