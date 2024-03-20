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
            NavigationLink(destination: IndexView()) {
                Text("Home")
                    .font(.title)
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
            }
            
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                    .font(.title)
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
            }
            
            NavigationLink(destination: GoalEditView()) {
                Text("Change Goal")
                    .font(.title)
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
            }
            
            NavigationLink(destination: ItemSearchView()) {
                Text("Find Item")
                    .font(.title)
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
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

