//
//  IntervalEditView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/30/24.
//

import SwiftUI

struct IntervalEditView: View {
    @Binding var interval: Interval
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    IntervalEditView(interval: .constant(Interval.defaultInterval))
}
