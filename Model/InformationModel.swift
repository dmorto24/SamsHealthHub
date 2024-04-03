//
//  InformationModel.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/20/24.
//
import Foundation

struct Information:Identifiable{
    var id: String
    var iid: String
    var calories: Int
    var calorieThresh: String
    var carbs: Int
    var carbThresh: String
    var cholesterol: Int
    var cholesterolThresh: String
    var fat: Int
    var fatThresh: String
    var protein: Int
    var proteinThresh: String
    var sodium: Int
    var sodiumThresh: String
}
