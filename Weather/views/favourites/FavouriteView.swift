//
//  FavoritesView.swift
//  Weather
//
//  Created by iosdev on 5.12.2022.
//

import SwiftUI

struct FavouriteView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.place)]) var favourites: FetchedResults<Favourite>
    
    @EnvironmentObject var fmi: FMI
    
    @State private var readyToNavigate = false
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(favourites) { favourite in
                        Button {
                            fmi.place = favourite.place!
                            readyToNavigate = true
                        } label: {
                            Text(favourite.place!)
                        }
                        .buttonStyle(.plain)
                        .navigationDestination(isPresented: $readyToNavigate) {
                            WeatherView()
                        }
                    }
                    .onDelete(perform: deleteFavourite)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Favourite", systemImage: "plus.circle")
                    }
                }
            }.sheet(isPresented: $showingAddView) {
                AddFavouriteView()
            }
            .navigationTitle("Favourites")
        }
    }
    
    private func deleteFavourite(offsets: IndexSet) {
        withAnimation {
            offsets.map { favourites[$0] }.forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
}

