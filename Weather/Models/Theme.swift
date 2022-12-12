import SwiftUI

enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    case primarytheme
    case testcolor
    case textcolor
    case accentcolor
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .accentcolor, .yellow, .primarytheme: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple, .testcolor, .textcolor: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
            rawValue.capitalized
        }
}
