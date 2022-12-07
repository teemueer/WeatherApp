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
    
    var place: String
    
    @StateObject var speechRecognition = SpeechRecognizer()
    @State private var isRecording:Bool = false
    @State private var transcript: String = ""
    
    // Created a map with a starting point @ Karamalmi, Espoo
    // TODO: Get location from device on startup and ask for
    //weather query
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.224, longitude: 24.70), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.005))
    
    //Hardcoded locations as a test.
    let locations = [
        Location(name: "Home", coordinate: CLLocationCoordinate2D(latitude: 60.182, longitude: 24.8)),
        Location(name: "Metropolia", coordinate: CLLocationCoordinate2D(latitude: 60.22412, longitude: 24.75860))
    ]
    
    init(place: String) {
        self.place = place
    }
    
    var body: some View {
        if fmi.data[place] == nil {
            ProgressView()
        } else if let data = fmi.data[place] {
            VStack {
                // Stack with map and current weather
                ZStack() {
                    Map(coordinateRegion: $mapRegion, annotationItems: locations){
                        location in
                        MapAnnotation(coordinate: location.coordinate){
                            VStack{
                                Text(location.name)
                                Circle()
                                    .stroke(.red,lineWidth: 2)
                                    .frame(width: 20,height: 20)
                                    .onTapGesture {
                                        print("tapped on \(location.name)")
                                    }
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 220.0)
                        .opacity(0.85)
                        .offset(x: -65.0, y: 0.0)
                    
                    VStack{
                        Text(place)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .hoverEffect(.lift)
                            .shadow(radius: 10)
                        
                        HStack(alignment: .bottom){
                            Text(String(format: "%.1f°C", data[0].temperature!))
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
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
                    .offset(x: -65.0, y: 0.0)
                    .padding()
                    
                }
                .frame(width: 350.0, height: 180.0)
                .cornerRadius(20)
                .shadow(radius: 10)
                Spacer()
                    .frame(height: 30.0)
                
                // Forecast section with scrollview
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
                                        Text(String(format: "%.1f°C", data[i].temperature!))
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
                        Text(String(format: "%.1f m/s", data[0].windSpeed!))
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
}