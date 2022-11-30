//
//  ContentView.swift
//  Weather
//
//  Created by iosdev on 28.11.2022.
//

import SwiftUI

struct MainView: View {
    let place: String
    let data: [WeatherStatus]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(self.place)
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                Image(systemName: self.data[0].symbol!)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text(String(format: "%.1f°C", self.data[0].temperature!))
                    .font(.system(size: 30, weight: .medium))
                    .foregroundColor(.white)
                    .padding()
                
                VStack {
                    ForEach(1..<30) { i in
                        if i % 3 == 0 {
                            ForecastView(status: self.data[i])
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct ForecastView: View {
    let status: WeatherStatus
    
    var body: some View {
        HStack {
            Text(self.status.hours)
                .foregroundColor(.white)
            Image(systemName: self.status.symbol!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text(String(format: "%.1f°C", self.status.temperature!))
                .foregroundColor(.white)
            Text(String(format: "%.1f m/s", self.status.windSpeed!))
                .foregroundColor(.white)
        }
    }
}

