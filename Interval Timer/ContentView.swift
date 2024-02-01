//
//  ContentView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        WorkoutList()
    }
}

#Preview {
    ContentView().environment(ModelData())
}
