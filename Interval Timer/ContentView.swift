//
//  ContentView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import SwiftUI
import SpotifyWebAPI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var spotify: SpotifyController
    
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        WorkoutList()
            .onAppear {
                if !spotify.isAuthorized {
                    spotify.authorize()
                }
            }
            .onOpenURL(perform: handleURL(_:))
    }
    
    func handleURL(_ url: URL) {
        guard url.scheme == self.spotify.loginCallbackURL.scheme else {
            print("not handling URL: unexpected scheme: '\(url)'")
            
            return
        }
        
        print("received redirect from Spotify: '\(url)'")
        
        spotify.api.authorizationManager.requestAccessAndRefreshTokens(
            redirectURIWithQuery: url,
            state: spotify.authorizationState
        )
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print("couldn't retrieve access and refresh tokens:\n\(error)")
            }
        })
        .store(in: &cancellables)
        
        self.spotify.authorizationState = String.randomURLSafe(length: 128)
    }
}

#Preview {
    ContentView().environment(ModelData())
}
