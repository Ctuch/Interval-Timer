//
//  TimerView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import SwiftUI

struct TimerCircleView: View {

    let secondsRemaining: Int
    
    private var minutes: Int {
        secondsRemaining / 60
    }
    
    private var seconds: Int {
        secondsRemaining % 60
    }
    
    private var displayTime: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 10)
            .overlay {
                Text(displayTime)
                    .font(.largeTitle)
                
            }
    }
}

#Preview {
    TimerCircleView(secondsRemaining: 131)
}
