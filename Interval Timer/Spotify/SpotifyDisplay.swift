//
//  SpotifyDisplay.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/6/24.
//

import SwiftUI

struct SpotifyDisplay: View {
    @EnvironmentObject var spotifyController: SpotifyController
    
    
    var body: some View {
        VStack {
            Text(spotifyController.currentSong.name)
                .font(.title)
            Text(spotifyController.currentSong.artist)
                .foregroundColor(.gray)
                .font(.title2)
            HStack {
                Button {
                    // go to last song
                } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                
                Button {
                    // play/pause music
                } label: {
                    Image(systemName: spotifyController.isPaused ? "pause.fill" : "play.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                .padding()
                
                Button {
                    // go to next song
                } label: {
                    Image(systemName: "forward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                
            }
            .padding([.leading, .trailing], 50)
        }
        
    }
}

#Preview {
    SpotifyDisplay()
}
