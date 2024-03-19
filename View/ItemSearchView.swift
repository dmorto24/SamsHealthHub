//  ItemSearchView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI

struct ItemSearchView: View {
    @ObservedObject var model = ItemViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            List (model.filteredItems(for: searchText)){
                item in Text(item.name)
            }
            .searchable(text: $searchText)
        }
    }
    init(){
        model.getItems()
    }
}


#Preview {
    ItemSearchView()
}
