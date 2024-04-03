//
//  SideMenuView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI

struct SideMenuView: View {
    
    @ObservedObject var uservm = UserViewModel()
    let currentUser: User?
    init(currentUser: User?) {
            self.currentUser = currentUser
        }
    var body: some View {
        VStack(spacing: 65) {
            NavigationLink(destination: HomeView(currentUser: uservm.currentUser)) {
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
            
            NavigationLink(destination: GoalEditView(currentUser: currentUser)) {
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
            
            NavigationLink(destination: IndexView().navigationBarBackButtonHidden(true)) {
                Text("Log Out")
                    .font(.title)
                    .foregroundColor(.white)
                    
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(){
            print(" from side view menu current user is" + (self.currentUser?.fname ?? "nothing there"))
        }
    }
}

//#Preview {
  //  SideMenuView(currentUser: uservm.currentUser)
//}
