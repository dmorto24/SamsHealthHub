//

//  InformationView.swift

//  SamsHealthHub

//

//  Created by Drew Morton on 3/20/24.

//



import Foundation
import SwiftUI

struct ItemDetailView: View {
    let item: ItemModel
    @ObservedObject var model = ItemViewModel()
    @State private var info: Information?

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            if let info = info {

                Text((item.description))
                Text("Calories: \(info.calories) : \(info.calorieThresh)")
                    .foregroundColor(info.calorieThresh == "High" ? .green : .red)
                Text("Carbs: \(info.carbs)g : \(info.carbThresh)")
                    .foregroundColor(info.carbThresh == "High" ? .green : .red)
                Text("Cholesterol: \(info.cholesterol)mg : \(info.cholesterolThresh)")
                    .foregroundColor(info.cholesterolThresh == "High" ? .green : .red)
                Text("Fat: \(info.fat)g : \(info.fatThresh)")
                    .foregroundColor(info.fatThresh == "High" ? .green : .red)
                Text("Protein: \(info.protein)g : \(info.proteinThresh)")
                    .foregroundColor(info.proteinThresh == "High" ? .green : .red)
                Text("Sodium: \(info.sodium)mg : \(info.sodiumThresh)")
                    .foregroundColor(info.sodiumThresh == "High" ? .green : .red)
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        model.getItemDetails(item: item) { fetchedInfo in
                            self.info = fetchedInfo
                        }
                    }
            }
        }
        .navigationTitle(item.name)
    }
}
