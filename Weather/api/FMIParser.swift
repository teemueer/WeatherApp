//
//  FMIParser.swift
//  Weather
//
//  Created by iosdev on 28.11.2022.
//

import Foundation

struct Measurement {
    let timestamp: String
    let value: Float
}

enum Identifier: String, CaseIterable {
    case Temperature
    case WeatherSymbol3
}

class FMIParser: NSObject, XMLParserDelegate {
    private var currentElement: String?
    private var currentIdentifier: Identifier?
    private var currentTimestamp: String?
    
    var temperatures = [Measurement]()
    var symbols = [Measurement]()
    
    // element start
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElement = elementName
        if elementName == "wml2:MeasurementTimeseries" {
            // example of an ID to be parsed: mts-1-1-WeatherSymbol3
            let id = attributeDict["gml:id"]?.components(separatedBy: "-").last
            self.currentIdentifier = Identifier(rawValue: id!)
        }
    }
    
    // element end
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElement = nil
    }
    
    // element value
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.currentElement == nil || self.currentIdentifier == nil {
            return
        }

        let s = string.trimmingCharacters(in: .whitespacesAndNewlines)

        if currentElement == "wml2:time" {
            self.currentTimestamp = s
            return
        }

        if (currentElement != "wml2:value") {
            return
        }

        let measurement = Measurement(timestamp: self.currentTimestamp!, value: Float(s)!)
        
        switch self.currentIdentifier {
        case .Temperature:
            self.temperatures.append(measurement)
        case .WeatherSymbol3:
            self.symbols.append(measurement)
        default:
            break
        }
    }
    
}
