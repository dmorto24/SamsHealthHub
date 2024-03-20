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
                    Text("Calories: \(info.calories)")
                    Text("Carbs: \(info.carbs)")
                    Text("Cholesterol: \(info.cholesterol)")
                    Text("Fat: \(info.fat)")
                    Text("Protein: \(info.protein)")
                    Text("Sodium: \(info.sodium)")

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


