//
//  ContentView.swift
//  Weather
//
//  Created by iosdev on 29.11.2022.
//

import SwiftUI

enum ViewType {
    case main
    case settings
    case favourites
}

class NavigationManager: ObservableObject {
    @Published var viewType: ViewType = .favourites
    @Published var showMenu = false
}

struct ContentView: View {
    @StateObject var fmi = FMI()
    @StateObject var nav = NavigationManager()
    
    var body: some View {
        if fmi.loading {
            ProgressView()
        } else {
            NavigationView {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        switch self.nav.viewType {
                        case .main:
                            BetaMainView(place: fmi.place!, data: fmi.data!)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.nav.showMenu ? geometry.size.width / 2 : 0)
                                .disabled(self.nav.showMenu ? true : false)
                        case .favourites:
                            FavouriteView()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.nav.showMenu ? geometry.size.width / 2 : 0)
                                .disabled(self.nav.showMenu ? true : false)
                        case .settings:
                            SettingsView()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.nav.showMenu ? geometry.size.width / 2 : 0)
                                .disabled(self.nav.showMenu ? true : false)
                        }
                        
                        if self.nav.showMenu {
                            MenuView(nav: self.nav)
                                .frame(width: geometry.size.width / 2)
                                .transition(.move(edge: .leading))
                        }
                    }
                }
                .navigationBarItems(leading: (
                    Button {
                        self.nav.showMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
            }
        }
    }
}


