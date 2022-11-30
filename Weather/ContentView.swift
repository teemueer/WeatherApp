//
//  ContentView.swift
//  Weather
//
//  Created by iosdev on 29.11.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fmi = FMI()
    
    var body: some View {
        if fmi.loading {
            ProgressView()
        } else {
            MainView(place: fmi.place!, data: fmi.data!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
