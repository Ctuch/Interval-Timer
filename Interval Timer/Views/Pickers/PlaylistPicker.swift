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
    @EnvironmentObject var spotify: SpotifyController
    
    @Binding var playlist: String //TODO: store relevant factors about the playlist (URI, name), update JSON
    
    @State private var playlists: [Playlist<PlaylistItemsReference>] = []
    @State private var isLoadingPlaylists = false
    
    @State private var cancellables: Set<AnyCancellable> = []
    
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
                    }
                }.pickerStyle(.menu)
            }
        }
        .onAppear(perform: getPlaylists)
    }
    
    func getPlaylists() {
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
                self.playlists.append(contentsOf: playlists)
            })
            .store(in: &cancellables)
        //TODO: decide to filter out playlists made by spotify? Order the results?
    }
}

/*#Preview {
    PlaylistPicker(playlist: .constant("Best Running Songs"))
}*/
