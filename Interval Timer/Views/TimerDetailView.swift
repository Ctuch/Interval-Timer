//
//  TimerDetailView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import SwiftUI
import AVFoundation

struct TimerDetailView: View {
    @Environment(ModelData.self) var modelData
    var workout: Workout
    @StateObject var workoutTimer = WorkoutTimer()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(workout.sequence[workoutTimer.intervalIndex].color.mainColor)
            VStack {
                TimerCircleView(secondsRemaining: workoutTimer.secondsRemaining)
                SpotifyDisplay()
                    .padding([.bottom], 50)
            }
            
        }
        .onAppear {
            startWorkout()
        }
        .onDisappear() {
            endWorkout()
        }
    }
    
    private func startWorkout() {
        workoutTimer.reset(intervals: workout.sequence)
        workoutTimer.intervalChangedAction = {
            let player = getPlayer(sound: workout.sequence[workoutTimer.intervalIndex].sound)
            player.seek(to: .zero)
            player.play()
        }
        workoutTimer.startTimer()
        
    }
    
    private func endWorkout() {
        workoutTimer.stopTimer()
    }
    
    private func getPlayer(sound: Sound) -> AVPlayer {
        switch sound {
        case .alien: return AVPlayer.sharedAlienPlayer
        case .ding: return AVPlayer.sharedDingPlayer
        case .ding2: return AVPlayer.sharedDing2Player
        case .ring: return AVPlayer.sharedRingPlayer
        case .none: return AVPlayer.sharedRingPlayer
        }
    }
}

#Preview {
    TimerDetailView(workout: ModelData().workouts[1])
        .environment(ModelData())
}
