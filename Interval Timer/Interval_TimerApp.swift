//
//  Interval_TimerApp.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI

@main
struct Interval_TimerApp: App {
    @State private var modelData = ModelData()
    @StateObject var spotify = SpotifyController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
                .environmentObject(spotify)
        }
    }
}
