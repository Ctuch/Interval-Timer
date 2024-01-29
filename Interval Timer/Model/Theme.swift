//
//  Theme.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import Foundation
import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {

    case yellow
    case blue
    case red
    case green
    
    var accentColor: Color {
        switch self {
        case .yellow: return .black
        case .blue, .red, .green: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
