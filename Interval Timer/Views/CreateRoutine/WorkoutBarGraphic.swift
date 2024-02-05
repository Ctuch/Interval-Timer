//
//  WorkoutBarGraphic.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct WorkoutBarGraphic: View {
    @Environment(ModelData.self) var modelData
    var workout: Workout
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(workout.sequence, id: \.self) { interval in
                    
                    let intWidth = CGFloat((Float(interval.time)/Float(workout.duration))) * geometry.size.width
                    Rectangle()
                        .frame(width: intWidth, height: 20)
                        .foregroundColor(interval.color.mainColor)
                }
            }
        }
    }
}

#Preview {
    WorkoutBarGraphic(workout: ModelData().workouts[1])
        .environment(ModelData())
}
