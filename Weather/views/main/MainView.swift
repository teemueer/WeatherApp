//
//  MainView.swift
//  TestEnvironment
//
//  Created by iosdev on 10.12.2022.
//

import SwiftUI

struct MainView: View {
    @AppStorage("darkMode") private var darkMode = false
    
    var body: some View {
        TabView {
            WeatherView()
                .tabItem { Image(systemName: "house").imageScale(.large) }
                .tag(1)
                .preferredColorScheme(darkMode ? .dark : .light)
            
            FavouriteView()
                .tabItem { Image(systemName: "list.dash").imageScale(.large) }
                .tag(2)
                .preferredColorScheme(darkMode ? .dark : .light)
            
            CalendarView()
                .tabItem { Image(systemName: "calendar").imageScale(.large) }
                .tag(3)
                .preferredColorScheme(darkMode ? .dark : .light)
            
            SettingsView()
                .tabItem { Image(systemName: "gear").imageScale(.large) }
                .tag(4)
                .preferredColorScheme(darkMode ? .dark : .light)

        }
    }
}

