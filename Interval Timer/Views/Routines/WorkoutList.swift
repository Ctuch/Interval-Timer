//
//  WorkoutList.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

struct WorkoutList: View {
    @Environment(ModelData.self) var modelData
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
                    //showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "plus.circle.fill")
                }
            }
        } detail: {
            Text("Select a Routine")
        }
    }
}

#Preview {
    WorkoutList().environment(ModelData())
}
