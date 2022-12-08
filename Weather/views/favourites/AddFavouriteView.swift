//
//  AddFavoriteView.swift
//  Weather
//
//  Created by iosdev on 6.12.2022.
//

import SwiftUI

struct AddFavouriteView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var place = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Place", text: $place)
                
                HStack {
                    Spacer()
                    Button("addFav") {
                        DataController().addFavourite(place: place, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

