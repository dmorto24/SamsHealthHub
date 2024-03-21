//
//  GoalModel.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/21/24.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Goal: Identifiable{
    var id: String
    var aid: DocumentReference
    var calories: String
    var carbs: String
    var cholesterol: String
    var fat: String
    var protein: String
    var sodium: String
}
