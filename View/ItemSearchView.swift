//  ItemSearchView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI

struct ItemSearchView: View {
    let currentUser: User?
    @ObservedObject var model = ItemViewModel()
    @ObservedObject var uservm = UserViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(model.filteredItems(for: searchText)) { item in
                NavigationLink(destination: ItemDetailView(item: item, currentUser: currentUser!)) {
                    Text(item.name)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Items")
        }
        .onAppear {
            if let user = currentUser {
                print("current user is \(user.fname)")
            } else {
                print("current user is nil")
            }
        }
    }
    
    init(currentUser: User?) {
        self.currentUser = currentUser
        model.getItems()
    }
}





/*#Preview {
    ItemSearchView(currentUser: nil)
}*/
