//
//  SpotifyDisplay.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/6/24.
//

import SwiftUI

struct SpotifyPlaybackView: View {
    @EnvironmentObject var spotifyController: SpotifySDK
    
    
    var body: some View {
        VStack {
            Text(spotifyController.currentSong.name)
                .font(.title)
            Text(spotifyController.currentSong.artist)
                .foregroundColor(.gray)
                .font(.title2)
            HStack {
                Button {
                    spotifyController.appRemote.playerAPI?.skip(toPrevious: nil)
                } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                
                Button {
                    if (spotifyController.isPaused) {
                        spotifyController.appRemote.playerAPI?.resume(nil)
                    }
                    else {
                        spotifyController.appRemote.playerAPI?.pause(nil)
                    }
                } label: {
                    Image(systemName: spotifyController.isPaused ? "play.fill" : "pause.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                .padding()
                
                Button {
                    spotifyController.appRemote.playerAPI?.skip(toNext: nil) //Can add callbacks!
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
    SpotifyPlaybackView()
}
