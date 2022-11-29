//
//  FMI.swift
//  Weather
//
//  Created by iosdev on 28.11.2022.
//

import Foundation

class FMI: ObservableObject {
    private let baseUrl = "https://opendata.fmi.fi/wfs"
    private var fmiParser = FMIParser()
    
    @Published var loading = false
    @Published var place: Place?
    
    init() {
        self.getForecast(placeName: "Espoo")
    }

    func getForecast(placeName: String) {
        self.loading = true
        
        var url = URL(string: baseUrl)
        
        let parametersString = Identifier.allCases.map({$0.rawValue}).joined(separator: ",")
        
        url?.append(queryItems: [
            URLQueryItem(name: "request", value: "getFeature"),
            URLQueryItem(name: "storedquery_id", value: "fmi::forecast::harmonie::surface::point::timevaluepair"),
            URLQueryItem(name: "place", value: placeName),
            URLQueryItem(name: "parameters", value: parametersString)
        ])
        
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("dataTaskWithRequest error: \(error)")
                return
            }
            
            guard let data = data else {
                print("dataTaskWithRequest data is nil")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self.fmiParser
            parser.parse()
            
            DispatchQueue.main.async {
                self.place = Place(name: placeName)
                self.place?.temperatures = self.fmiParser.temperatures
                self.place?.symbols = self.fmiParser.symbols
                self.loading = false
            }
        }
        task.resume()
    }
    
}

func Measurement2SystemName(measurement: Measurement) -> String {
    switch measurement.value {
    case 3.0:
        return "cloud"
    case 51.0:
        return "cloud.snow"
    default:
        return "sun"
    }
}
