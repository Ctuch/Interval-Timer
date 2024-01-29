//
//  WorkoutRow.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

struct WorkoutRow: View {
    var workout: Workout
    
    var body: some View {
        HStack {
            Text(workout.name)
                .fontWeight(.bold)
            Spacer()
            Text(workout.formatTime)
        }
    }
}

#Preview {
    WorkoutRow(workout: ModelData().workouts[0])
}
