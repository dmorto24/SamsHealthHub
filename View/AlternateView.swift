//
//  AlternateView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 4/8/24.
//
import Foundation
import SwiftUI

struct AlternateView: View {
    let item: ItemModel
    let currentUser: User
    let information: [Information]
    let items: [ItemModel]
    @ObservedObject var model = ItemViewModel()
    @ObservedObject var uservm = UserViewModel()
    @State private var info: Information?
    @State private var currentGoals: Goal?
    @State private var userHasGoals: Bool = true
    @State private var userGoal = [Goal]()
    
    init(item: ItemModel, currentUser: User, information: [Information], items: [ItemModel]) {
        self.item = item
        self.currentUser = currentUser
        self.information = information
        self.items = items
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(items) { item in
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue.opacity(0.3))
                                .frame(minWidth: 150, minHeight: 50)
                                .overlay(
                                    Text(item.name)
                                        .padding()
                                )
                            
                            Spacer()
                            
                      
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text("Calories:")
                                    Rectangle()
                                        .fill(information[0].calorieThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].calorieThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                HStack {
                                    Text("Carbs:")
                                    Rectangle()
                                        .fill(information[0].carbThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].carbThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                HStack {
                                    Text("Cholesterol:")
                                    Rectangle()
                                        .fill(information[0].cholesterolThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].cholesterolThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                HStack {
                                    Text("Fat:")
                                    Rectangle()
                                        .fill(information[0].fatThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].fatThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                HStack {
                                    Text("Protein:")
                                    Rectangle()
                                        .fill(information[0].proteinThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].proteinThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                HStack {
                                    Text("Sodium:")
                                    Rectangle()
                                        .fill(information[0].sodiumThresh == "high" ? Color.green : Color.red)
                                        .frame(width: 50, height: 20)
                                        .overlay(
                                            Text(information[0].sodiumThresh == "low" ? "Low" : "High")
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                        )
                                }
                                
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}





