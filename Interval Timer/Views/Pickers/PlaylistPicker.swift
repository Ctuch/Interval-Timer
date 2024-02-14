//
//  PlaylistsView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/8/24.
//

import SwiftUI
import Combine
import SpotifyWebAPI

struct PlaylistPicker: View {
    @EnvironmentObject var spotify: SpotifyWeb
    
    @Binding var playlist: PlaylistInfo
    
    @State private var playlists: [PlaylistInfo] = []
    @State private var isLoadingPlaylists = false
    
    @State private var cancellables: Set<AnyCancellable> = []
    
    @State private var testPlaylists: [PlaylistInfo] = [
        PlaylistInfo(name: "Rock all the time", uri: ""),
        PlaylistInfo(name: "21 gun salute", uri: ""),
        PlaylistInfo(name: "soul jams", uri: "")
    ]
    
    var body: some View {
        VStack {
            if playlists.isEmpty && isLoadingPlaylists {
                HStack {
                    ProgressView()
                        .padding()
                    Text("Loading Playlists")
                }
            } else {
                Picker("Playlist", selection: $playlist) {
                    ForEach(playlists, id: \.self) {playlist in
                        Text(playlist.name)
                            .tag(PlaylistInfo(name: playlist.name, uri: playlist.uri))
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
        }
        .onAppear(perform: getPlaylists)
    }
    
    func getPlaylists() {
        // Preview only
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            playlists = testPlaylists
            return
        }
            
        if self.playlists.count > 0 {
            return
        } else {
            self.isLoadingPlaylists = true
            self.playlists = []
            spotify.api.currentUserPlaylists(limit: 50)
                .extendPages(spotify.api)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    self.isLoadingPlaylists = false
                    if case .failure(let error) = completion {
                        print("failed to get playlists", error.localizedDescription)
                    }
                }, receiveValue: { playlistPage in
                    let playlists = playlistPage.items
                    for playlist in playlists {
                        self.playlists.append(PlaylistInfo(name: playlist.name, uri: playlist.uri))
                    }
                    
                })
                .store(in: &cancellables)
            //TODO: decide to filter out playlists made by spotify? Order the results?
        }
    }
}

#Preview {
    PlaylistPicker(playlist: .constant(PlaylistInfo(name: "Best Running Songs", uri: "")))
}
