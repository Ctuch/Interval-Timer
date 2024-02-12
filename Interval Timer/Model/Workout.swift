//
//  Workout.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import Foundation

struct Workout: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var numCycles: Int
    var warmUp: Interval
    var lowInt: Interval
    var highInt: Interval
    var coolDown: Interval
    
    var duration: Int {
        return warmUp.time + numCycles * (lowInt.time + highInt.time) + coolDown.time
    }
    
    var sequence: [Interval] {
        var temp = [warmUp]
        for _ in 1...numCycles {
            temp.append(lowInt)
            temp.append(highInt)
        }
        temp.append(coolDown)
        return temp
    }
    
    init(id: Int = 0, name: String = "", duration: Int = 300, numCycles: Int = 1, warmUp: Interval, lowInt: Interval, highInt: Interval, coolDown: Interval) {
        self.id = id
        self.name = name
        self.numCycles = numCycles
        self.warmUp = warmUp
        self.lowInt = lowInt
        self.highInt = highInt
        self.coolDown = coolDown
    }
    
    static func DisplayTime(timeSeconds: Int) -> String {
        let minutes = timeSeconds / 60
        let seconds = timeSeconds % 60
        
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
}

extension Workout {
    static var defaultWorkout: Workout {
        Workout(warmUp: Interval(name: .warmUp, time: 60, color: .yellow, sound: .none, playlist: PlaylistInfo(name: "", uri: "")),
                lowInt: Interval(name: .lowInt, time: 120, color: .green, sound: .ding2, playlist: PlaylistInfo(name: "", uri: "")),
                highInt: Interval(name: .highInt, time: 60, color: .red, sound: .ding, playlist: PlaylistInfo(name: "", uri: "")),
                coolDown: Interval(name: .coolDown, time: 60, color: .blue, sound: .ring, playlist: PlaylistInfo(name: "", uri: "")))
    }
}
