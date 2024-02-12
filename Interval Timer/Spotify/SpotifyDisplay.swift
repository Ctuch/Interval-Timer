//
//  SpotifyDisplay.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/8/24.
//

import SwiftUI

struct SpotifyDisplay: View {
    @EnvironmentObject var spotify: SpotifyController
    
    @State private var currentSong: Track = Track(name: "Eye of the Tiger", artist: "Survivor")
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            Text(currentSong.name)
                .font(.title)
            Text(currentSong.artist)
                .foregroundColor(.gray)
                .font(.title2)
            HStack {
                Button {
                    //
                } label: {
                    Image(systemName: "backward.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                
                Button {
                    if (isPaused) {
                       //
                    }
                    else {
                        //
                    }
                } label: {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .buttonStyle(.plain)
                .padding()
                
                Button {
                    
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
