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
    var duration: Int
    var numCycles: Int
    var warmUp: Interval
    var lowInt: Interval
    var highInt: Interval
    var coolDown: Interval
    
    var minutes: Int {
        duration / 60
    }
    var seconds: Int {
        duration % 60
    }
    
    var formatTime: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    
    var sequence: [Interval] {
        var temp = [warmUp]
        for i in 1...numCycles {
            temp.append(lowInt)
            temp.append(highInt)
        }
        temp.append(coolDown)
        return temp
    }
    
}
