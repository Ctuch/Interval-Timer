//
//  WorkoutTimer.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/29/24.
//

import Foundation
import AVFoundation

@MainActor
final class WorkoutTimer: ObservableObject {
    
    @Published var secondsRemaining = 0
    @Published var intervalIndex = 0
    
    private(set) var intervals: [Interval]
    
    var intervalChangedAction: (() -> Void)?
    
    private weak var timer: Timer?
    private var timerStopped = false
    private var lengthInSeconds = 0
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    
    init(intervals: [Interval] = []) {
        self.intervals = intervals
        guard intervalIndex < intervals.count else { return }
        secondsRemaining = intervals[intervalIndex].time
        lengthInSeconds = secondsRemaining
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in 
            self?.update()
        }
            
        timer?.tolerance = 0.1
        changeToInterval(at: 0)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timerStopped = true
    }
    
    private func changeToInterval(at index: Int) {
        guard index < intervals.count else { return }
        intervalIndex = index
        secondsRemaining = intervals[index].time
        lengthInSeconds = secondsRemaining
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !timerStopped else {return}
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsRemaining = max(lengthInSeconds - secondsElapsed, 0)
            if secondsRemaining == 15 {
                let player = AVPlayer.sharedFifteenPlayer
                player.seek(to: .zero)
                player.play()
            }
            // Can also play the warning if less than 30 s and lowInt and warnings enabled
            if secondsRemaining == 0 {
                changeToInterval(at: intervalIndex + 1)
                intervalChangedAction?()
                // Play sound?? -> see callback fn
            }
        }
    }
    
    func reset (intervals: [Interval]) {
        self.intervals = intervals
        guard intervalIndex < intervals.count else { return }
        secondsRemaining = intervals[intervalIndex].time
        lengthInSeconds = secondsRemaining
    }
}
