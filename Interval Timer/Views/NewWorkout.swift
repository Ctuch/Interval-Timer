//
//  NewWorkout.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/29/24.
//

import SwiftUI

struct NewWorkout: View {
    @Environment(ModelData.self) var modelData
    @State private var newWorkout = Workout.defaultWorkout
    @Binding var isPresentingNewWorkoutView: Bool
    
    var body: some View {
        NavigationStack {
            WorkoutDetail(workout: $newWorkout)
                .navigationTitle("New Routine")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingNewWorkoutView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            isPresentingNewWorkoutView = false
                            modelData.workouts.append(newWorkout)
                        }
                    }
                }
        }
    }
}

#Preview {
    NewWorkout(isPresentingNewWorkoutView: .constant(true)).environment(ModelData())
}
