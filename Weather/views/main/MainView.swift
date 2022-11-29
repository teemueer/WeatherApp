//
//  ContentView.swift
//  Weather
//
//  Created by iosdev on 28.11.2022.
//

import SwiftUI

struct MainView: View {
    let place: Place
    
    var body: some View {
        VStack {
            Text(place.name)
                .font(.system(size: 32, weight: .medium, design: .default))
                .padding()
            
            VStack {
                Image(systemName: Measurement2SystemName(measurement: self.place.symbols[0]))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                
                Text(String(format: "%.1f°C", self.place.temperatures[0].value))
                    .font(.system(size: 70, weight: .medium))
            }
        }
    }
}

