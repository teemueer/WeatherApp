import Foundation

enum Identifier: String, CaseIterable {
    case Humidity
    case Temperature
    case WeatherSymbol3
    case WindDirection
    case WindSpeedMS
}

struct Measurement {
    let timestamp: String
    let value: Float
}

var gMeasurements = [Identifier: [Measurement]]()

class FMIParser: NSObject, XMLParserDelegate {
    let baseUrl = "https://opendata.fmi.fi/wfs"
    
    var parser: XMLParser?
    
    var currentElement: String?
    var currentIdentifier: Identifier?
    var currentTimestamp: String?
    
    func getForecast(place: String) {
        var url = URL(string: baseUrl)
        url?.append(queryItems: [
            URLQueryItem(name: "request", value: "getFeature"),
            URLQueryItem(name: "storedquery_id", value: "fmi::forecast::harmonie::surface::point::timevaluepair"),
            //URLQueryItem(name: "storedquery_id", value: "fmi::observations::weather::timevaluepair"),
            URLQueryItem(name: "place", value: place),
            URLQueryItem(name: "parameters", value: Identifier.allCases.map({ "\($0)" }).joined(separator: ","))
        ])
        
        self.parser = XMLParser(contentsOf: url!)
        self.parser?.delegate = self
        self.parser?.parse()
    }
    
    // element start
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        self.currentElement = elementName
        if elementName == "wml2:MeasurementTimeseries" {
            self.currentIdentifier = Identifier(rawValue: attributeDict["gml:id"]!.components(separatedBy: "-").last!)
        }
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
        
        if gMeasurements[self.currentIdentifier!] == nil {
            gMeasurements[self.currentIdentifier!] = []
        }
        
        gMeasurements[self.currentIdentifier!]?.append(Measurement(timestamp: self.currentTimestamp!, value: Float(s)!))
    }
    
    // element end
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement = nil
    }
    
}

let fmiParser = FMIParser()
fmiParser.getForecast(place: "Espoo")

// weather symbol svgs can be found from here: https://github.com/fmidev/opendata-resources/tree/master/symbols
if let measurements = gMeasurements[.WeatherSymbol3] {
    for m in measurements {
        print("timestamp: \(m.timestamp), value: \(m.value)")
    }
}
