//
//  WorkoutDetail.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

struct WorkoutDetail: View {
    @Binding var workout: Workout
    @Environment(ModelData.self) var modelData
    @State private var isPresentingEditInterval = false
    @State private var editingInterval = Interval.defaultInterval
    
    
    var body: some View {
        List {
            TextField("Workout Name", text: $workout.name)
            Button {
                editingInterval = workout.warmUp
                isPresentingEditInterval.toggle()
            } label: {
                IntervalRow(interval: workout.warmUp)
            }
            Button {
                
            } label: {
                IntervalCycleRow(numCycles: $workout.numCycles)
            }.frame(maxHeight: 80)
            Button {
                editingInterval = workout.lowInt
                isPresentingEditInterval.toggle()
            } label: {
                IntervalRow(interval: workout.lowInt)
            }
            Button {
                editingInterval = workout.highInt
                isPresentingEditInterval.toggle()
            } label: {
                IntervalRow(interval: workout.highInt)
            }
            Button {
                editingInterval = workout.coolDown
                isPresentingEditInterval.toggle()
            } label: {
                IntervalRow(interval: workout.coolDown)
            }
            WorkoutBarGraphic(workout: workout)
                
        }
        //TODO: fix not being able to tap in middle
        .buttonStyle(.plain)
        .sheet(isPresented: $isPresentingEditInterval) {
            NavigationStack {
                IntervalEditView(interval: $editingInterval, minutes: .constant(Interval.defaultInterval.time / 60), seconds: .constant(Interval.defaultInterval.time % 60))
                    .navigationTitle("\(editingInterval.name.rawValue)")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditInterval = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditInterval = false
                                saveChangesToInterval()
                            }
                        }
                    }
            }
        }
    }
    
    func saveChangesToInterval()  {
        if editingInterval.name == Interval.IntervalType.warmUp {
            workout.warmUp = editingInterval
        } else if editingInterval.name == Interval.IntervalType.lowInt {
            workout.lowInt = editingInterval
        } else if editingInterval.name == Interval.IntervalType.highInt {
            workout.highInt = editingInterval
        } else {
            workout.coolDown = editingInterval
        }
    }
}

#Preview("withInfo") {
    WorkoutDetail(workout: .constant(ModelData().workouts[0])).environment(ModelData())
}

#Preview("default") {
    WorkoutDetail(workout: .constant(Workout.defaultWorkout)).environment(ModelData())
}
