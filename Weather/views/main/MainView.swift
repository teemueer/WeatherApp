//
//  MainView.swift
//  TestEnvironment
//
//  Created by iosdev on 10.12.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            WeatherView()
                .tabItem { Image(systemName: "house").imageScale(.large) }
                .tag(1)
            
            FavouriteView()
                .tabItem { Image(systemName: "list.dash").imageScale(.large) }
                .tag(2)
             
            
            CalendarView()
                .tabItem { Image(systemName: "calendar").imageScale(.large) }
                .tag(3)
            
            SettingsView()
                .tabItem { Image(systemName: "gear").imageScale(.large) }
                .tag(4)

        }
    }
}

