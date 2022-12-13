//
//  WeatherApp.swift
//  Weather
//
//  Created by iosdev on 5.12.2022.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var fmi = FMI()
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
