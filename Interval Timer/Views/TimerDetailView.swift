//
//  TimerDetailView.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/27/24.
//

import SwiftUI
import AVFoundation
import Combine

struct TimerDetailView: View {
    @Environment(ModelData.self) var modelData
    @EnvironmentObject var spotifySDK: SpotifySDK
    @EnvironmentObject var spotifyWeb: SpotifyWeb
    @State private var isDone: Bool = false
    var index: Int
    private var workout: Workout {
        modelData.workouts[index]
    }
    
    @StateObject var workoutTimer = WorkoutTimer()
    
    @State private var cancellables: Set<AnyCancellable> = []
    
    var body: some View {
        ZStack {
            if isDone {
                Text("Yay you did it!")
                    .font(.title)
            } else {
                Rectangle()
                    .fill(workout.sequence[workoutTimer.intervalIndex].color.mainColor)
                VStack {
                    TimerCircleView(secondsRemaining: workoutTimer.secondsRemaining)
                    SpotifyPlaybackView()
                        .padding([.bottom], 50)
                }
            }
        }
        .onAppear {
            //getAllAvailableSongs()
            startWorkout()
        }
        .onDisappear() {
            endWorkout()
        }
    }
    
    private func startWorkout() {
        workoutTimer.reset(intervals: workout.sequence)
        
        // Start the warmup playlist
        spotifySDK.appRemote.playerAPI?.play(workout.warmUp.playlist.uri, asRadio: false, callback: { item, error in
            print("started the warm up")
            if let error = error {
                print(error.localizedDescription)
            }
        })
        
        workoutTimer.intervalChangedAction = {
            if workoutTimer.intervalIndex == workout.sequence.count {
                endWorkout()
                return
            }
            
            let player = getPlayer(sound: workout.sequence[workoutTimer.intervalIndex].sound)
            player.seek(to: .zero)
            player.play()
            
            switchPlaylist()
           
        }
        workoutTimer.startTimer()
        
    }
    
    private func endWorkout() {
        workoutTimer.stopTimer()
        isDone = true
    }
    
    private func switchPlaylist() {
        guard workoutTimer.intervalIndex < workout.sequence.count else { return }
        let uri = workout.sequence[workoutTimer.intervalIndex].playlist.uri
        spotifySDK.appRemote.playerAPI?.play(uri, asRadio: false, callback: { item, error in
            print("set the playlist on interval", workoutTimer.intervalIndex)
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    private func getAllAvailableSongs() {
        loadSongsForIntervalType(interval: modelData.workouts[index].warmUp)
        loadSongsForIntervalType(interval: modelData.workouts[index].lowInt)
        loadSongsForIntervalType(interval: modelData.workouts[index].highInt)
        loadSongsForIntervalType(interval: modelData.workouts[index].coolDown)
    }
    
    private func loadSongsForIntervalType(interval: Interval) {
        spotifyWeb.api.playlistTracks(interval.playlist.uri)
            .extendPages(spotifyWeb.api)
            .receive(on: RunLoop.main)
            .collect()
            .sink(receiveCompletion: { completion in
               
                if case .failure(let error) = completion {
                    print("failed to get playlist items", error.localizedDescription)
                }
            }, receiveValue: { trackArray in
                let tracks = trackArray[0].items
                var songUris: [String] = []
                for track in tracks {
                    if let song = track.item {
                        songUris.append(song.uri!)
                    }
                }
                songUris.shuffle()
                
                switch interval.name {
                case .warmUp:
                    modelData.workouts[index].warmUp.playlist.availableSongs = songUris
                    spotifySDK.appRemote.playerAPI?.play(songUris[0], asRadio: false, callback: { item, error in
                        print("hello down here")
                    })
                case .lowInt:
                    modelData.workouts[index].lowInt.playlist.availableSongs = songUris
                case .highInt:
                    modelData.workouts[index].highInt.playlist.availableSongs = songUris
                case .coolDown:
                    modelData.workouts[index].coolDown.playlist.availableSongs = songUris
                }
            })
            .store(in: &cancellables)
    }
    
    private func getPlayer(sound: Sound) -> AVPlayer {
        switch sound {
        case .alien: return AVPlayer.sharedAlienPlayer
        case .ding: return AVPlayer.sharedDingPlayer
        case .ding2: return AVPlayer.sharedDing2Player
        case .ring: return AVPlayer.sharedRingPlayer
        case .none: return AVPlayer.sharedRingPlayer
        }
    }
}

#Preview {
    TimerDetailView(index: 1)
        .environment(ModelData())
}
