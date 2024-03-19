//
//  GoalVM.swift
//  SamsHealthHub
//
//  Created by Drew Morton on 3/19/24.
//

import Foundation

class GoalViewModel: ObservableObject {
    @Published var list = ["high","low","medium","no pref"]
}
