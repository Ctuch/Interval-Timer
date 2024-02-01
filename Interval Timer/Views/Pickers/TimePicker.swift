//
//  TimePicker.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct TimePicker: View {
    @Binding var currentMins: Int
    @Binding var currentSecs: Int

    private let minutes = [Int](0...60)
    private let seconds = [Int](0...60)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Picker("Minutes", selection: $currentMins) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(value) min")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
                Picker("Seconds", selection: $currentSecs) {
                    ForEach(seconds, id: \.self) { value in
                        Text("\(value) sec")
                            .tag(value)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 2, alignment: .center)
            }
        }
    }
}

#Preview {
    TimePicker(currentMins: .constant(2), currentSecs: .constant(46))
}
