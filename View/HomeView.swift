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
    @State private var caloriesPreference = "No Preference"
    @State private var carbsPreference = "No Preference"
    @State private var cholesterolPreference = "No Preference"
    @State private var fatPreference = "No Preference"
    @State private var proteinPreference = "No Preference"
    @State private var sodiumPreference = "No Preference"
    
    //Function for checking if userHasGoals, if so set the variable to true
    func GoalChecker(){
        if userHasGoals == true{
            //Include the code to retrieve the preference data here
            caloriesPreference = "Medium"
            carbsPreference = "Medium"
            cholesterolPreference = "Low"
            fatPreference = "Low"
            proteinPreference = "High"
            sodiumPreference = "Low"
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    if userHasGoals == true{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.blue.opacity(0.3))
                            .frame(height: 200)
                            .padding()
                            .overlay(
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Calories: \(caloriesPreference)")
                                        Rectangle()
                                        .fill(caloriesPreference == "No Preference" ? Color.gray : (caloriesPreference == "High" ? Color.green : (caloriesPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(caloriesPreference == "High" ? "+" : (caloriesPreference == "Low" ? "-" : (caloriesPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Carbs: \(carbsPreference)")
                                        Rectangle()
                                        .fill(carbsPreference == "No Preference" ? Color.gray : (carbsPreference == "High" ? Color.green : (carbsPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(carbsPreference == "High" ? "+" : (carbsPreference == "Low" ? "-" : (carbsPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Cholesterol: \(cholesterolPreference)")
                                        Rectangle()
                                        .fill(cholesterolPreference == "No Preference" ? Color.gray : (cholesterolPreference == "High" ? Color.green : (cholesterolPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(cholesterolPreference == "High" ? "+" : (cholesterolPreference == "Low" ? "-" : (cholesterolPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Fat: \(fatPreference)")
                                        Rectangle()
                                        .fill(fatPreference == "No Preference" ? Color.gray : (fatPreference == "High" ? Color.green : (fatPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(fatPreference == "High" ? "+" : (fatPreference == "Low" ? "-" : (fatPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Protein: \(proteinPreference)")
                                        Rectangle()
                                        .fill(proteinPreference == "No Preference" ? Color.gray : (proteinPreference == "High" ? Color.green : (proteinPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(proteinPreference == "High" ? "+" : (proteinPreference == "Low" ? "-" : (proteinPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
                                        .padding(.leading, 5)
                                    }
                                    HStack{
                                        Text("Sodium: \(sodiumPreference)")
                                        Rectangle()
                                        .fill(sodiumPreference == "No Preference" ? Color.gray : (sodiumPreference == "High" ? Color.green : (sodiumPreference == "Low" ? Color.red : Color.yellow)))
                                        .overlay(
                                            Text(sodiumPreference == "High" ? "+" : (sodiumPreference == "Low" ? "-" : (sodiumPreference == "Medium" ? "=" : "")))
                                                .foregroundColor(.black)
                                        )
                                        .frame(width: 15, height: 20)
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
                        NavigationLink(destination: ContentView()) {
                            ButtonView(title: "Goals")
                        }
                    }
                    else {
                        NavigationLink(destination: ContentView()) {
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
                        SideMenuView()
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
            GoalChecker()
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

#Preview {
    HomeView()
}
