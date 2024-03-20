//
//  index.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//
import SwiftUI

struct IndexView: View {
    @State private var showMenu: Bool = false
    @State private var userHasGoals: Bool = false
    
    var body: some View {
        //if userHasGoals == true{
            
        //}
        //else{
            
        //}
        
        
        
        NavigationView {
            ZStack{
                VStack {
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



