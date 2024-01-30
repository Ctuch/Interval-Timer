//
//  IntervalRow.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/29/24.
//

import SwiftUI

struct IntervalRow: View {
    var interval: Interval
    
    var body: some View {
        HStack {
            Text(interval.name.rawValue)
            Spacer()
            ZStack {
                Capsule()
                    .fill(interval.color.mainColor)
                    .frame(width: 80, height: 40)
                Text(Workout.DisplayTime(timeSeconds: interval.time))
            }
        }
        
    }
}

#Preview {
    IntervalRow(interval: Workout.defaultWorkout.warmUp)
}
