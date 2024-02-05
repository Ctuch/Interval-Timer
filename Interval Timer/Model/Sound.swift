//
//  Sound.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/2/24.
//

import Foundation
import AVFoundation

enum Sound: String, CaseIterable, Identifiable, Codable {
    
    case ding = "ding"
    case ding2 = "ding x2"
    case ring = "ring"
    case alien = "alien"
    case none = "none"
    
    var name: String {
        rawValue
    }
    
    var id: String {
        name
    }
}
