//
//  FavouriteRowView.swift
//  Weather
//
//  Created by iosdev on 6.12.2022.
//

import SwiftUI

struct FavouriteRowView: View {
    let place: String
    let data: [WeatherStatus]
    
    var body: some View {
        HStack {
            Text(place)
            Text(String(format: "%.1f°C", data[0].temperature!))
        }
    }
}

