//
//  WorkoutBarGraphic.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct WorkoutBarGraphic: View {
    var workout: Workout
    @State private var size: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(workout.sequence, id: \.self) { interval in
                    let intWidth = CGFloat((Float(interval.time)/Float(workout.duration))) * geometry.size.width
                    Rectangle()
                        .frame(width: intWidth, height: 20)
                        .foregroundColor(interval.color.mainColor)
                        
                }
            }.onAppear {
                size = geometry.size
            }
        }
    }
}

#Preview {
    WorkoutBarGraphic(workout: Workout.defaultWorkout)
}
