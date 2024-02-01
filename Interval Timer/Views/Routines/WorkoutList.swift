//
//  WorkoutList.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

struct WorkoutList: View {
    @Environment(ModelData.self) var modelData
    @State private var isPresentingNewRoutine = false
    @State private var newRoutine = Workout.defaultWorkout
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(modelData.workouts) { workout in
                    NavigationLink {
                        TimerDetailView(workout: workout)
                    } label: {
                        WorkoutRow(workout: workout)
                    }
                }
            }
            .animation(.default, value: modelData.workouts)
            .navigationTitle("Routines")
            .toolbar {
                Button {
                    isPresentingNewRoutine.toggle()
                } label: {
                    Label("User Profile", systemImage: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewRoutine) {
                NewWorkout(isPresentingNewWorkoutView: $isPresentingNewRoutine)
            }
        } detail: {
            Text("Select a Routine")
        }
    }
}

#Preview {
    WorkoutList().environment(ModelData())
}
