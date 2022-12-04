//
//  favouriteMapView.swift
//  Weather
//
//  Created by Juho on 3.12.2022.
//

import SwiftUI


struct favouriteMapView: View {
    var data: aFavourite
    var fmi = FMI()
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(data.name)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.top)
            VStack(alignment: .leading){
                HStack(){
                    Spacer()
                    Text(data.placeName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    Spacer()
                        .frame(width: 100.0)
                    Image(systemName:"cloud.sun")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: 60, height: 50)
                    Spacer()
                }
                .frame(height: 70.0)
                VStack{
                    HStack{
                        
                        Text("-12°C")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Divider().overlay(Color.white)
                            .frame(width: 4.0, height: 15.0)
                        Text("-12°C")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Divider().overlay(Color.white)
                            .frame(width: 4.0, height: 15.0)
                        Text("-12°C")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Divider().overlay(Color.white)
                            .frame(width: 4.0, height: 15.0)
                        
                        Text("-12°C")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        
                        
                        
                    }.padding()
                    Spacer()
                }

            }
            .frame(width: 350.0, height: 150.0)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct favouriteMapView_Previews: PreviewProvider {
    static var previews: some View {
        favouriteMapView(data: aFavourite(name: "University", lat: 60.22421, long: 24.75848, placeName: "Karamalmi"))
    }
}
