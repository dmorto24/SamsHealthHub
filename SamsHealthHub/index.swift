//
//  index.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
// 
import poopcock
import SwiftUI

struct IndexView: View {
    @State private var showMenu: Bool = false

    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        ButtonView(title: "Goals")
                    }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    NavigationLink(destination: ItemSearchView()) {
                        ButtonView(title: "Find Item")
                    }
                    
                    Spacer()
                }
                
                GeometryReader { _ in
                    HStack{
                        Spacer()
                        SideMenuView()
                            .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                    }
                }
                .background(Color.black.opacity(showMenu ? 0.5 : 0))
            }
                .navigationTitle("Index Page")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    
                    Button{
                        self.showMenu.toggle()
                    } label: {
                        
                        if showMenu{
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        else{
                            Image(systemName: "text.justify")
                                .font(.title)
                        }
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



