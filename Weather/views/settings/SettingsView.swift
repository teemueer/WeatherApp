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
        VStack(){
            //Header
            HStack(alignment: .center){
                Spacer()
                Image(systemName: "arrow.backward")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30.0, height: 30)
                    Spacer()
                Text("settings")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }.padding(.trailing, 90)
            Divider()

            
            //Settings begin here
            
            //Unit of measurement
            Text("unit")
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    ZStack{
                        Text("℃")
                            .foregroundColor(Theme.textcolor.mainColor)
                    }
                    .frame(width: 60.0, height: 60.0)
                    .background(Theme.testcolor.mainColor)
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
                        .foregroundColor(Theme.textcolor.mainColor)
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
                        .foregroundColor(Theme.textcolor.mainColor)
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
                .background(Theme.yellow.mainColor)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                HStack{
                    Text("selected");Text(":\(selectedText)")
                }
            }
            
            //Color mode
            Text("color")
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Toggle(isOn: $lightMode) {
                        Text("toggleTextColor")
                    }
                    Spacer()
                }
                .frame(width: 330.0, height: 80.0)
                .background(Theme.yellow.mainColor)
                .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                HStack{
                    if(lightMode){
                        Text("selected");Text(":");Text("light")
                        
                    }else{
                        Text("selected");Text(":");Text("dark")
                        
                    }
                }
            }
            Spacer()
        }.background(Theme.primarytheme.mainColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
