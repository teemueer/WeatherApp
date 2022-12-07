//
//  ContentView.swift
//  Weather
//
//  Created by iosdev on 5.12.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var fmi: FMI
    
    var body: some View {
        if fmi.data.count == 0 {
            ProgressView()
        } else {
            TabView {
                WeatherView(place: "Espoo")
                    .tabItem { Image(systemName: "house").imageScale(.large) }
                    .tag(1)

                FavouriteView()
                    .tabItem { Image(systemName: "list.dash").imageScale(.large) }
                    .tag(1)
                
                SettingsView()
                    .tabItem { Image(systemName: "gear").imageScale(.large) }
                    .tag(2)
            }
        }
    }
}

