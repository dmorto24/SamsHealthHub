//
//  GoalEditView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI



struct GoalEditView: View {
    @ObservedObject var model = GoalViewModel()
    var body: some View {
        List (model.list, id: \.self){
            item in Text(item)
        }
    }
}

#Preview {
    GoalEditView()
}

