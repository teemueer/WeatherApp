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
    @Published var place: String?
    @Published var data: [WeatherStatus]?
    
    init() {
        self.getForecast(place: "Espoo")
    }

    func getForecast(place: String) {
        self.loading = true
        
        var url = URL(string: baseUrl)
        
        let parametersString = Identifier.allCases.map({$0.rawValue}).joined(separator: ",")
        
        url?.append(queryItems: [
            URLQueryItem(name: "request", value: "getFeature"),
            URLQueryItem(name: "storedquery_id", value: "fmi::forecast::harmonie::surface::point::timevaluepair"),
            URLQueryItem(name: "place", value: place),
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
                self.place = place
                self.data = self.fmiParser.data
                self.loading = false
                
                self.data?.forEach { (weatherStatus) in
                    print(weatherStatus.date, weatherStatus.symbol)
                }
            }
        }
        task.resume()
    }
    
}
