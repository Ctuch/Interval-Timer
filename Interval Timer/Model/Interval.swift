//
//  Interval.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import Foundation

struct Interval: Hashable, Codable {
    var name: IntervalType
    var minutes: Int
    var seconds: Int
    var color: Theme
    var sound: Sound
    var playlist: PlaylistInfo
    
    var time: Int {
        return minutes * 60 + seconds
    }
    
    enum IntervalType: String, CaseIterable, Codable {
        case warmUp = "Warm Up"
        case lowInt = "Low Intensity"
        case highInt = "High Intensity"
        case coolDown = "Cool Down"
    }
    
    init(name: IntervalType, minutes: Int, seconds: Int, color: Theme, sound: Sound, playlist: PlaylistInfo) {
        self.name = name
        self.minutes = minutes
        self.seconds = seconds
        self.color = color
        self.sound = sound
        self.playlist = playlist
    }
}

extension Interval {
    static var defaultInterval: Interval {
        Interval(name: .warmUp, minutes: 2, seconds: 12, color: .blue, sound: .ding, playlist: PlaylistInfo(name: "", uri: ""))
    }
}
