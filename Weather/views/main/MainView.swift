import SwiftUI

struct MainView: View {
    var place: String
    var data: [WeatherStatus]
    @StateObject var fmi = FMI()
    @State private var placeSearch: String = ""
    @StateObject var speechRecognition = SpeechRecognizer()
    @State private var isRecording:Bool = false
    @State private var transcript: String = ""
    
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack{
                    TextField("Search", text:$placeSearch)
                        .border(.secondary)
                        .shadow(radius: 20)
                        .background(Color.white)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    
                    Button(action: {
                        fmi.getForecast(place: placeSearch)
                    }, label: {
                        Text("Search")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color.blue)
                            .cornerRadius(20)
                    }).padding(5)
                    
                    Image(systemName: "mic.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                        .foregroundColor(Color.white)
                        .onLongPressGesture(minimumDuration: 0.4){
                            self.isRecording = true
                            print("Recording started")
                            if(isRecording){
                                speechRecognition.reset()
                                speechRecognition.transcribe()
                                print("Transcription started!")
                            }
                            
                        }.simultaneousGesture(DragGesture(minimumDistance: 0).onEnded{_ in if self.isRecording{
                            self.isRecording = false
                            print("Ended dictation")
                        }
                            speechRecognition.stopTranscribing()
                            if(speechRecognition.transcript.count != 0){
                                placeSearch = speechRecognition.transcript
                            }else{ print("Dictation failed")}
                            
                            
                        })
                        .padding()
                    
                    }
                    
                
                
                Text(fmi.place ?? "Initializing")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                Image(systemName: fmi.data?[0].symbol! ?? "cloud.sun")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text(String(format: "%.1f°C", fmi.data?[0].temperature! ?? " "))
                    .font(.system(size: 30, weight: .medium))
                    .foregroundColor(.white)
                    .padding()
                
                VStack {
                }
            }
            
            Spacer()
        }
        Spacer()
    }
}

struct ForecastView: View {
    var status: WeatherStatus
    
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

