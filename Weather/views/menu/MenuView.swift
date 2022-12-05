//
//  MenuView.swift
//  Weather
//
//  Created by iosdev on 5.12.2022.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var nav: NavigationManager

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "house").imageScale(.large)
                    .foregroundColor(.white)
                Text("Home").onTapGesture {
                    self.nav.viewType = .main
                    self.nav.showMenu = false
                }.foregroundColor(.white)
            }
            .padding(.top, 100)
            
            HStack {
                Image(systemName: "heart").imageScale(.large)
                    .foregroundColor(.white)
                Text("Favourites").onTapGesture {
                    self.nav.viewType = .favourites
                    self.nav.showMenu = false
                }.foregroundColor(.white)
            }

            HStack {
                Image(systemName: "gear").imageScale(.large)
                    .foregroundColor(.white)
                Text("Settings").onTapGesture {
                    self.nav.viewType = .settings
                    self.nav.showMenu = false
                }.foregroundColor(.white)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}
