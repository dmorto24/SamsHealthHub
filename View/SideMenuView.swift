//
//  SideMenuView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 65) {
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                    .font(.title)
                    .foregroundColor(.white)
            }
    
            NavigationLink(destination: GoalEditView()) {
                Text("Change Goal")
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    SideMenuView() 
}

