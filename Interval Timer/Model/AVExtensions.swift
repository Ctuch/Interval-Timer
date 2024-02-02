//
//  AVTest.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/2/24.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    static let sharedDing2Player: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding x2", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    static let sharedRingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ring", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    static let sharedAlienPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "alien", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
