//
//  ContentView.swift
//  TestEnvironment
//
//  Created by Teemu/Juho on 10.12.2022.
//

import SwiftUI
import Foundation
import MapKit

struct FavouriteDataView: View {
    
    @StateObject var fmi = FMI()
    @StateObject var geolocation = geolocate()
    @AppStorage("selectedUnit") private var selectedUnit = 0
    @StateObject var speechRecognition = SpeechRecognizer()
    @State private var isRecording:Bool = false
    @State private var searchBar: String = ""
    var unitConvert = unitConverter()
    
    var place:String

    
    var body: some View {
        if fmi.data[fmi.loc] == nil {
            ProgressView()
        } else if let data = fmi.data[fmi.loc] {
            
            VStack{
                //Stack with map + location info + current weather
                ZStack() {
                    Map(coordinateRegion: $geolocation.mapRegion,showsUserLocation: true)
                        .ignoresSafeArea()
                        .accentColor(Color(.systemBlue))
                        .onAppear(){
                            fmi.getForecast(place: place)
                            geolocation.nameToCoordinates(location: place)
                        }
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 220.0)
                        .opacity(0.85)
                        .offset(x: /*@START_MENU_TOKEN@*/-65.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    
                    VStack{
                        //Use fmi.loc if geolocation.currentCity doesnt work!
                        Text(fmi.loc)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .hoverEffect(/*@START_MENU_TOKEN@*/.lift/*@END_MENU_TOKEN@*/)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        HStack(alignment: .bottom){
                            switch selectedUnit{
                            case 1:
                                Text(String(format:"%.1f°F"
                                            , unitConvert.convertUnits(unit: data[0].temperature!
                                                                       , state:selectedUnit)))
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            case 2:
                                Text(String(format:"%.1fK"
                                            , unitConvert.convertUnits(unit: data[0].temperature!
                                                                       , state:selectedUnit)))
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            default:
                                Text(String(format:"%.1f°C",data[0].temperature!))
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                                .frame(width: 30.0)
                            Image(systemName: data[0].symbol!)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 50, height: 50)
                            
                        }
                        .frame(width: 200.0)
                        
                    }
                    .offset(x: /*@START_MENU_TOKEN@*/-65.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    .padding()
                    
                }
                .frame(width: 350.0, height: 180.0)
                .cornerRadius(20)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
                    .frame(height: 30.0)
                
                //Horizontal scroll weather forecast
                VStack(){
                    ScrollView(.horizontal, showsIndicators: false) {
                        VStack{
                            HStack{
                                ForEach(2..<21) { i in
                                    VStack{
                                        Text(data[i].hours)
                                        Image(systemName: data[i].symbol!)
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40.0, height: 40)
                                        switch selectedUnit{
                                        case 1:
                                            Text(String(format:"%.1f°F"
                                                        , unitConvert.convertUnits(unit: data[i].temperature!
                                                                                   , state:selectedUnit)))
                                        case 2:
                                            Text(String(format:"%.1fK"
                                                        , unitConvert.convertUnits(unit: data[i].temperature!
                                                                                   , state:selectedUnit)))
                                        default:
                                            Text(String(format: "%.1f°C", data[i].temperature!))
                                        }
                                        
                                    }
                                    .frame(width: 80.0, height: 150.0)
                                    .cornerRadius(10.0)
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(width: 345.0, height: 150.0)
                    
                    
                }
                .frame(width: 350.0, height: 180.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.031, brightness: 0.712)/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                HStack{
                    ZStack{
                        VStack{
                            Text("Cloud")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Text("Coverage")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                                .frame(height: 5.5)
                            Text(String(format: "%.0f %%",data[0].totalCloudCover!))
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }.padding()
                    }
                    .frame(width: 170.0, height: 150.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    
                    ZStack{
                        VStack{
                            Text("Humidity")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                                .frame(height: 25.0)
                            Text(String(format: "%.1f %%",data[0].humidity!))
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }.padding()
                    }
                    .frame(width: 170.0, height: 150.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()
            }
        }
    }
}

