//
//  SettingsView.swift
//  Weather
//
//  Created by Juho on 4.12.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State var lightMode:Bool = false
    @State var selectedC: Bool = false
    @State var selectedF: Bool = false
    @State var selectedK: Bool = false
    @State var selectedText:String = "Celsius"
    @State var color: Color = .white
    
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
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.trailing, 90)
            Divider()

            
            //Settings begin here
            
            //Unit of measurement
            Text("Unit Of Measurement")
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    ZStack{
                        Text("℃")
                        
                    }
                    .frame(width: 60.0, height: 60.0)
                    .background(color)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        if(!selectedC){
                            selectedC.toggle()
                            selectedText = "Celsius"
                            color = .blue
                            if(selectedK){selectedK.toggle()};if(selectedF){selectedF.toggle()}
                        }
                    }
                    Spacer()
                    ZStack{
                        Text("℉")
                    }
                    .frame(width: 60.0, height: 60.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        if(!selectedF){
                            selectedF.toggle()
                            selectedText = "Fahrenheit"
                            color = .blue
                            if(selectedK){selectedK.toggle()};if(selectedC){selectedC.toggle()}
                        }
                    }
                    Spacer()
                    ZStack{
                        Text("K")
                    }
                    .frame(width: 60.0, height: 60.0)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    }
                    
                    Spacer()
                    
                }
                .frame(width: 330.0, height: 80.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text("Selected: \(selectedText)")
            }
            
            //Color mode
            Text("Color Mode")
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Toggle(isOn: $lightMode) {
                        Text("Toggle Light/Dark mode")
                    }
                    Spacer()
                }
                .frame(width: 330.0, height: 80.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                if(lightMode){Text("Selected: Light")}else{Text("Selected: Dark")}
                
            }
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
