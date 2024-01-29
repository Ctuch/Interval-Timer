//
//  TimerDetailView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import SwiftUI

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
                Text("hello")
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
        workoutTimer.startTimer()
    }
    
    private func endWorkout() {
        workoutTimer.stopTimer()
    }
}

#Preview {
    TimerDetailView(workout: ModelData().workouts[1])
        .environment(ModelData())
}
