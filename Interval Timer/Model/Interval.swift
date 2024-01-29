//
//  Interval.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import Foundation

struct Interval: Hashable, Codable {
    var time: Int
    var color: Theme
    var sound: Sound
    var playlist: String
    
    enum Sound: String, CaseIterable, Codable {
        case ding = "ding"
        case ding2 = "ding x2"
        case ring = "ring"
        case none = "none"
    }
}
