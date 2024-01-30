//
//  IntervalCycleRow.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/29/24.
//

import SwiftUI

struct IntervalCycleRow: View {
    @Binding var numCycles: Int
    
    var body: some View {
        HStack {
            Text("Interval Cycle")
            Spacer()
            Picker("Sets", selection: $numCycles) {
                ForEach(1...30, id: \.self) { number in
                    Text(number == 1 ? "1 Set" : "\(number) Sets")
                }
            }.pickerStyle(.wheel)
                
        }
    }
}

#Preview {
    IntervalCycleRow(numCycles: .constant(5))
}
