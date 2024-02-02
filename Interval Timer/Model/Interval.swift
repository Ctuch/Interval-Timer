//
//  Interval.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import Foundation

struct Interval: Hashable, Codable {
    var name: IntervalType
    var time: Int
    var color: Theme
    var sound: Sound
    var playlist: String
    
    enum IntervalType: String, CaseIterable, Codable {
        case warmUp = "Warm Up"
        case lowInt = "Low Intensity"
        case highInt = "High Intensity"
        case coolDown = "Cool Down"
    }
    
    init(name: IntervalType, time: Int, color: Theme, sound: Sound, playlist: String) {
        self.name = name
        self.time = time
        self.color = color
        self.sound = sound
        self.playlist = playlist
    }
}

extension Interval {
    static var defaultInterval: Interval {
        Interval(name: .warmUp, time: 60, color: .blue, sound: .ding, playlist: "")
    }
}
