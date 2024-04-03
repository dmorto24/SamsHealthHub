//
//  HomeView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//
import SwiftUI
//import UIKit

struct HomeView: View {
    
    @State private var showMenu: Bool = false
    
    @State private var userHasGoals: Bool = true
    //HERE ARE THE DUMMIES, I HATE YOU DUMMIES PLEASE KYS AND DIE
    @State private var userGoal = [Goal]()
    @State private var caloriesPreference = "High"
    @State private var carbsPreference = "No Preference"
    @State private var cholesterolPreference = "No Preference"
    @State private var fatPreference = "No Preference"
    @State private var proteinPreference = "No Preference"
    @State private var sodiumPreference = "No Preference"
    
    @ObservedObject var uservm = UserViewModel()
    let currentUser: User?
    init(currentUser: User?) {
            self.currentUser = currentUser
        }
    
    //Function for checking if userHasGoals, if so set the variable to true
    func GoalChecker(goal: Goal?) {
        if let goal = goal {
            //Include the code to retrieve the preference data here
            caloriesPreference = goal.calories as String
            carbsPreference = goal.carbs as String
            cholesterolPreference = goal.cholesterol as String
            fatPreference = goal.fat as String
            proteinPreference = goal.protein as String
            sodiumPreference = goal.sodium as String
        } else {
            self.userHasGoals = false
            // If no goal is found, set preferences to defaults or no preference
            caloriesPreference = "No Preference"
            carbsPreference = "No Preference"
            cholesterolPreference = "No Preference"
            fatPreference = "No Preference"
            proteinPreference = "No Preference"
            sodiumPreference = "No Preference"
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    if userHasGoals == true{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue.opacity(0.3))
                            .frame(height: 300)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Calories: \(caloriesPreference)")
                                        Rectangle()
                                        .fill(caloriesPreference == "no preference" ? Color.gray : (caloriesPreference == "high" ? Color.green : (caloriesPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(caloriesPreference == "high" ? "↑" : (caloriesPreference == "low" ? "↓" : (caloriesPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Carbs: \(carbsPreference)")
                                        Rectangle()
                                        .fill(carbsPreference == "no preference" ? Color.gray : (carbsPreference == "high" ? Color.green : (carbsPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(carbsPreference == "high" ? "↑" : (carbsPreference == "low" ? "↓" : (carbsPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Cholesterol: \(cholesterolPreference)")
                                        Rectangle()
                                        .fill(cholesterolPreference == "no preference" ? Color.gray : (cholesterolPreference == "high" ? Color.green : (cholesterolPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(cholesterolPreference == "high" ? "↑" : (cholesterolPreference == "low" ? "↓" : (cholesterolPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Fat: \(fatPreference)")
                                        Rectangle()
                                        .fill(fatPreference == "no preference" ? Color.gray : (fatPreference == "high" ? Color.green : (fatPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(fatPreference == "high" ? "↑" : (fatPreference == "low" ? "↓" : (fatPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Protein: \(proteinPreference)")
                                        Rectangle()
                                        .fill(proteinPreference == "no preference" ? Color.gray : (proteinPreference == "high" ? Color.green : (proteinPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(proteinPreference == "high" ? "↑" : (proteinPreference == "low" ? "↓" : (proteinPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Sodium: \(sodiumPreference)")
                                        Rectangle()
                                        .fill(sodiumPreference == "no preference" ? Color.gray : (sodiumPreference == "high" ? Color.green : (sodiumPreference == "low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(sodiumPreference == "high" ? "↑" : (sodiumPreference == "low" ? "↓" : (sodiumPreference == "medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 20, height: 25)
                                        .padding(.leading, 5)
                                    }
                                }
                                .padding()
                            )
                    }
                    else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue.opacity(0.3))
                            .frame(height: 200)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("No Goals Created!")
                                    Text("Use the Button Below to Add a Goal!")
                                }
                                    .padding()
                            )
                    }
                    
                    Spacer()
                    
                    if userHasGoals == true {
                        NavigationLink(destination: GoalEditView(currentUser: currentUser)) {
                            ButtonView(title: "Goals")
                        }
                    }
                    else {
                        NavigationLink(destination: GoalEditView(currentUser: currentUser)) {
                            ButtonView(title: "Add Goals")
                        }
                    }
                    Spacer()
                        .frame(height: 20)
                    NavigationLink(destination: ItemSearchView()) {
                        ButtonView(title: "Find Item")
                    }
                    Spacer()
                }
                .padding()
                GeometryReader { _ in
                    HStack{
                        Spacer()
                        SideMenuView(currentUser: currentUser)
                            .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                    }
                }
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }
            .toolbar {
                Button(action: {
                    self.showMenu.toggle()
                }) {
                    Image(systemName: showMenu ? "xmark" : "text.justify")
                        .font(.title)
                        .foregroundColor(showMenu ? .red : .primary)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            print("current user is" + (self.currentUser?.fname ?? "nothing there"))
            uservm.getGoals(for: currentUser!) { goal, error in
                if let error = error {
                    // Handle error
                    print("Error fetching goal: \(error.localizedDescription)")
                } else {
                    // Pass the fetched goal to GoalChecker
                    GoalChecker(goal: goal)
                }
            }
        }
        
    }
    struct ButtonView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}
//#Preview {
  //  HomeView(currentUser: self.currentUser)
    //}
