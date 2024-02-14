//
//  SpotifyDisplay.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/6/24.
//

import SwiftUI

struct SpotifyPlaybackView: View {
    @EnvironmentObject var spotifySDK: SpotifySDK
    
    
    var body: some View {
        VStack {
            Text(spotifySDK.currentSong.name)
                .font(.title)
            Text(spotifySDK.currentSong.artist)
                .foregroundColor(.gray)
                .font(.title2)
            HStack {
                Button {
                    spotifySDK.appRemote.playerAPI?.skip(toPrevious: nil)
                } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                
                Button {
                    if (spotifySDK.isPaused) {
                        spotifySDK.appRemote.playerAPI?.resume(nil)
                    }
                    else {
                        spotifySDK.appRemote.playerAPI?.pause(nil)
                    }
                } label: {
                    Image(systemName: spotifySDK.isPaused ? "play.fill" : "pause.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                .padding()
                
                Button {
                    spotifySDK.appRemote.playerAPI?.skip(toNext: nil) //Can add callbacks!
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
