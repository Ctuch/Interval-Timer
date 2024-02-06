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
    @StateObject var spotifyController = SpotifyController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
                .onOpenURL { url in
                    spotifyController.setAccessToken(from: url)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification), perform: { _ in
                    spotifyController.connect()
                })
        }
    }
}
