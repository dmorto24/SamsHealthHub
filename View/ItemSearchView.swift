//  ItemSearchView.swift
//  SamsHealthHub
//
//  Created by Cole Clavey on 3/18/24.
//

import SwiftUI

struct ItemSearchView: View {
    @ObservedObject var model = ItemViewModel()
    var body: some View {
        List (model.list){
            item in Text(item.name)
        }
    }
    init(){
        model.getItems()
    }
}

#Preview {
    ItemSearchView()
}
