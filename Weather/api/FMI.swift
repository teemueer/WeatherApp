//
//  FMI.swift
//  Weather
//
//  Created by iosdev on 28.11.2022.
//

import Foundation
import Combine

class FMI: ObservableObject {
    private let baseUrl = "https://opendata.fmi.fi/wfs"
    private var fmiParser = FMIParser()
    @Published var place: String = "Rovaniemi"
    @Published var data: [WeatherStatus] = []
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $place.sink { [weak self] term in
            self?.getForecast()
        }.store(in: &subscriptions)
    }

    func getForecast() {
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
                self.data = self.fmiParser.data
                self.data.forEach { (weatherStatus) in
                    print(weatherStatus.date, weatherStatus.temperature)
                }
            }
        }
        task.resume()
    }
    
}
