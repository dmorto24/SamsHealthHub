//
//  GoalEditView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct GoalEditView: View {
    @ObservedObject var uservm = UserViewModel()
    @State private var userGoal = [Goal]()
    @State private var isAlertShown = false
    @State private var navigateHome = false
    @State private var caloriesPreference = "No Preference"
    @State private var carbsPreference = "No Preference"
    @State private var cholesterolPreference = "No Preference"
    @State private var fatPreference = "No Preference"
    @State private var proteinPreference = "No Preference"
    @State private var sodiumPreference = "No Preference"
    
    let currentUser: User?
    init(currentUser: User?) {
        self.currentUser = currentUser
    }
    
    func PullGoals(goal: Goal?) {
        if let goal = goal {
            // Include the code to retrieve the preference data here
            self.caloriesPreference = goal.calories
            self.carbsPreference = goal.carbs
            self.cholesterolPreference = goal.cholesterol
            self.fatPreference = goal.fat
            self.proteinPreference = goal.protein
            self.sodiumPreference = goal.sodium
        } else {
            // Set default values if no goal is found
            self.caloriesPreference = "No Preference"
            self.carbsPreference = "No Preference"
            self.cholesterolPreference = "No Preference"
            self.fatPreference = "No Preference"
            self.proteinPreference = "No Preference"
            self.sodiumPreference = "No Preference"
        }
    }
    
    var body: some View {
        VStack {
            AttributePicker(attribute: "Calories", preference: $caloriesPreference, defaultValue: self.caloriesPreference, currentUser: currentUser)
            AttributePicker(attribute: "Carbs", preference: $carbsPreference, defaultValue: self.carbsPreference, currentUser: currentUser)
            AttributePicker(attribute: "Cholesterol", preference: $cholesterolPreference, defaultValue: self.cholesterolPreference, currentUser: currentUser)
            AttributePicker(attribute: "Fat", preference: $fatPreference, defaultValue: self.fatPreference, currentUser: currentUser)
            AttributePicker(attribute: "Protein", preference: $proteinPreference, defaultValue: self.proteinPreference, currentUser: currentUser)
            AttributePicker(attribute: "Sodium", preference: $sodiumPreference, defaultValue: self.sodiumPreference, currentUser: currentUser)
            
            Button(action: {
                // Handle submit action
                submitGoal(user: currentUser!)
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .alert(isPresented: $isAlertShown) {
            Alert(title: Text("Goal Updated"),
                  message: Text("Your goal has been updated successfully."),
                  dismissButton: .default(Text("OK")){
                    navigateHome = true
            })
        }
        .background(
            NavigationLink(destination: HomeView(currentUser: currentUser), isActive: $navigateHome) {
                EmptyView()
            }
        )
        .onAppear {
            // Fetch user goals on appearance
            uservm.getGoals(for: currentUser!) { goal, error in
                if let error = error {
                    // Handle error
                    print("Error fetching goal: \(error.localizedDescription)")
                } else {
                    // Pass the fetched goal to PullGoals
                    PullGoals(goal: goal)
                }
            }
        }
    }

    
    func submitGoal(user: User) {
        
        
        let db = Firestore.firestore()
        let goalsCollection = db.collection("Goal")
        let userID = user.id
        let userDocRef = db.collection("User").document(userID)
        let query = goalsCollection.whereField("aid", isEqualTo: userDocRef).limit(to: 1)
        
        // Check if a goal already exists for the current user
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error checking for existing goal: \(error.localizedDescription)")
                return
            }
            
            if let existingGoalDocument = snapshot?.documents.first {
                // If a goal exists, update it
                let existingGoalRef = existingGoalDocument.reference
                
                let updatedData: [String: Any] = [
                    "calories": self.caloriesPreference,
                    "carbs": self.carbsPreference,
                    "cholesterol": self.cholesterolPreference,
                    "fat": self.fatPreference,
                    "protein": self.proteinPreference,
                    "sodium": self.sodiumPreference
                ]
                
                existingGoalRef.setData(updatedData, merge: true) { error in
                    if let error = error {
                        print("Error updating goal: \(error.localizedDescription)")
                    } else {
                        print("Goal updated successfully")
                    }
                }
            } else {
                // If no goal exists, create a new one
                let newGoalData: [String: Any] = [
                    "aid": userDocRef,
                    "calories": self.caloriesPreference,
                    "carbs": self.carbsPreference,
                    "cholesterol": self.cholesterolPreference,
                    "fat": self.fatPreference,
                    "protein": self.proteinPreference,
                    "sodium": self.sodiumPreference
                ]
                
                goalsCollection.addDocument(data: newGoalData) { error in
                    if let error = error {
                        print("Error creating new goal: \(error.localizedDescription)")
                    } else {
                        print("New goal created successfully")
                    }
                }
            }
        }
        isAlertShown = true
    }
    
    
    struct AttributePicker: View {
        let attribute: String
        @Binding var preference: String
        let defaultValue: String
        let currentUser: User?
        
        var body: some View {
            HStack {
                Text("\(attribute):")
                    .padding(.trailing, 10)
                Picker("", selection: $preference) {
                    Text("No Preference").tag("no preference")
                    Text("Low").tag("low")
                    Text("Medium").tag("medium")
                    Text("High").tag("high")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.vertical, 5)
        }
    }
}
