//
//  BetaMainView.swift
//  Weather
//
//  Created by Juho on 1.12.2022.
//
import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate:CLLocationCoordinate2D
}

struct WeatherView: View {
    @EnvironmentObject var fmi: FMI

    @StateObject var speechRecognition = SpeechRecognizer()
    @State private var isRecording:Bool = false
    @State private var transcript: String = ""
    @StateObject var geolocation = geolocate()
    
    
    // Created a map with a starting point @ Karamalmi, Espoo
    //TODO: Get location from device on startup and ask for
    //weather query
    
    
    
    
    
    //Hardcoded locations as a test.
    let locations = [
        Location(name: "Home", coordinate: CLLocationCoordinate2D(latitude: 60.182, longitude: 24.8)),
        Location(name: "Metropolia", coordinate: CLLocationCoordinate2D(latitude: 60.22412, longitude: 24.75860))
    ]
    
    var body: some View {
        VStack(){
            // Stack with map and current weather
            ZStack() {
                Map(coordinateRegion: $geolocation.mapRegion,showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemBlue))
                .onAppear{
                    geolocation.checkLocationServices()
                }
 
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 220.0)
                    .opacity(0.85)
                    .offset(x: /*@START_MENU_TOKEN@*/-65.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                
                VStack{
                    Text(fmi.place)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .hoverEffect(/*@START_MENU_TOKEN@*/.lift/*@END_MENU_TOKEN@*/)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    HStack(alignment: .bottom){
                        Text(String(format: "%.1f°C", fmi.data[0].temperature!))
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Spacer()
                            .frame(width: 30.0)
                        Image(systemName: fmi.data[0].symbol!)
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
            
            // Forecast section with scrollview
            VStack(){
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack{
                        HStack{
                            ForEach(2..<21) { i in
                                VStack{
                                    Text(fmi.data[i].hours)
                                    Image(systemName: fmi.data[i].symbol!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40.0, height: 40)
                                    Text(String(format: "%.1f°C", fmi.data[i].temperature!))
                                }
                                .frame(width: 80.0, height: 150.0)
                                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
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
                    Text(String(format: "%.1f m/s", fmi.data[0].windSpeed!))
                }
                .frame(width: 170.0, height: 150.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)

                ZStack{
                    
                }
                .frame(width: 170.0, height: 150.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                
 
            }.padding().frame(width: 350.0, height: 200)
            
            Spacer()
        
            
        }
    }
}



