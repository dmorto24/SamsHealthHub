//

//  InformationView.swift

//  SamsHealthHub

//

//  Created by Drew Morton on 3/20/24.

//

//Pull user goals to calculate goal matches
//Color text based on user goals and not high or low
import Foundation
import SwiftUI

struct ItemDetailView: View {
    let item: ItemModel
    let currentUser: User
    @ObservedObject var model = ItemViewModel()
    @ObservedObject var uservm = UserViewModel()

    @State private var info: Information?
    @State private var currentGoals: Goal?
    @State private var userHasGoals: Bool = true
    @State private var userGoal = [Goal]()
    @State private var type: String = ""
    @State private var matches: Int = 0
    @State private var calorieItemGoal: String = ""
    @State private var carbItemGoal: String = ""
    @State private var cholesterolItemGoal: String = ""
    @State private var fatItemGoal: String = ""
    @State private var proteinItemGoal: String = ""
    @State private var sodiumItemGoal: String = ""
    @State private var caloriesPreference: String = ""
    @State private var carbsPreference: String = ""
    @State private var cholesterolPreference: String = ""
    @State private var fatPreference: String = ""
    @State private var proteinPreference: String = ""
    @State private var sodiumPreference: String = ""
    @State private var information: [Information]?
    @State private var items: [ItemModel]?
    
    init(item: ItemModel, currentUser: User) {
           self.item = item
           self.currentUser = currentUser
       }
    
    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            if let info = info {

                Text((item.description))
                Text("Calories: \(info.calories) : \(info.calorieThresh)")
                    .foregroundColor(info.calorieThresh == "high" ? .green : .red)
                Text("Carbs: \(info.carbs)g : \(info.carbThresh)")
                    .foregroundColor(info.carbThresh == "high" ? .green : .red)
                Text("Cholesterol: \(info.cholesterol)mg : \(info.cholesterolThresh)")
                    .foregroundColor(info.cholesterolThresh == "high" ? .green : .red)
                Text("Fat: \(info.fat)g : \(info.fatThresh)")
                    .foregroundColor(info.fatThresh == "high" ? .green : .red)
                Text("Protein: \(info.protein)g : \(info.proteinThresh)")
                    .foregroundColor(info.proteinThresh == "high" ? .green : .red)
                Text("Sodium: \(info.sodium)mg : \(info.sodiumThresh)")
                    .foregroundColor(info.sodiumThresh == "high" ? .green : .red)
                //if statement to determine if all goals match, if not then do alternatives
                if matches != 6{
                    if let info = information, let items = items {
                        HStack {
                            Spacer()
                            NavigationLink(
                                destination: AlternateView(item: item, currentUser: currentUser, information: info, items: items),
                                label: {
                                    Text("View Alternatives")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(.blue))
                                }
                            )
                        }
                       } else {
                       ProgressView("Loading...")
                           .onAppear {
                               // Call the function to fetch information and items
                               model.alternateItems(calorieGoal: calorieItemGoal, carbGoal: carbItemGoal,  cholesterolGoal: cholesterolItemGoal, fatGoal: fatItemGoal, proteinGoal: proteinItemGoal, sodiumGoal: sodiumItemGoal, matches: matches, type: type, item: item) { info, items, error in
                                   if let error = error {
                                       // Handle the error
                                       print("Error fetching alternate items: \(error.localizedDescription)")
                                   } else {
                                       // Update information and items
                                       self.information = info
                                       self.items = items
                                   }
                               }
                           }
                       }
                }
            }
            else {
                ProgressView("Loading...")
                    .onAppear {
                        uservm.getGoals(for: currentUser) { goal, error in
                                    if let error = error {
                                        print("Error fetching user goals: \(error.localizedDescription)")
                                    } else if let goal = goal {
                                        self.currentGoals = goal
                                        caloriesPreference = goal.calories as String
                                        carbsPreference = goal.carbs as String
                                        cholesterolPreference = goal.cholesterol as String
                                        fatPreference = goal.fat as String
                                        proteinPreference = goal.protein as String
                                        sodiumPreference = goal.sodium as String
                                        setThresholds()
                                    }
                                }
                        
                        model.getItemDetails(item: item) { fetchedInfo in
                            self.info = fetchedInfo
                        }
                    }
            }
            
        }
        .navigationTitle(item.name)
        .padding(.trailing, 20)
    }
    
    private func setThresholds() {
        guard let info = info else { return }
        calorieItemGoal = info.calorieThresh
        carbItemGoal = info.carbThresh
        
        print(carbItemGoal)
        print(carbsPreference)
        
        cholesterolItemGoal = info.cholesterolThresh
        fatItemGoal = info.fatThresh
        proteinItemGoal = info.proteinThresh
        sodiumItemGoal = info.sodiumThresh
        type = info.type
        print(type)
        if caloriesPreference == calorieItemGoal{
            matches += 1
            print("A")
        }
        if carbsPreference == carbItemGoal{
            matches += 1
            print("B")
        }
        if cholesterolPreference == cholesterolItemGoal{
            matches += 1
            print("C")
        }
        if fatPreference == fatItemGoal{
            matches += 1
            print("D")
        }
        if proteinPreference == proteinItemGoal{
            matches += 1
            print("E")
        }
        if sodiumPreference == sodiumItemGoal{
            matches += 1
            print("F")
        }
        print("Matches", matches)
    }
}
