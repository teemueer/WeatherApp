//
//  FavouriteView.swift
//  Weather
//
//  Created by Juho on 3.12.2022.
//

import SwiftUI

//A potential datatype
struct aFavourite {
    var name: String
    var lat: Float
    var long: Float
    var placeName: String
}

struct FavouriteView: View {
    var body: some View {
        VStack{
            //Header
            HStack(alignment: .center){
                Spacer()
                Image(systemName: "arrow.backward")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30)
                    Spacer()
                Text("Favourites")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.trailing, 90)
            Divider()
            
            //Blueprint for favourited location
            ScrollView{
                favouriteMapView(data: aFavourite(name: "University", lat: 60.22421, long: 24.75848, placeName: "Karamalmi"))
                    Divider()
                favouriteMapView(data: aFavourite(name: "Home", lat: 60.22421, long: 24.75848, placeName: "Inkoo"))
                Divider()
                favouriteMapView(data: aFavourite(name: "Cabin", lat: 60.22421, long: 24.75848, placeName: "Jyväskylä"))
                
                ZStack{
                    Image(systemName:"plus.circle.fill")
                        .resizable()
                        .frame(width: 50,height: 50)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                        
                }.padding()
            }
            
            
            //Button
            /*TODO: Add functionality to add a favourite*/
            
            
            
            
            
            
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
