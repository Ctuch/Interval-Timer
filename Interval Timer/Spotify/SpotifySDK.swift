//
//  SpotifyController.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/6/24.
//

import Foundation
import Combine


class SpotifySDK: NSObject, ObservableObject {
    
    private static let clientId: String = {
          if let clientId = ProcessInfo.processInfo
                  .environment["CLIENT_ID"] {
              return clientId
          }
          fatalError("Could not find 'CLIENT_ID' in environment variables")
      }()
    
    let spotifyRedirectURL = URL(string:"spotify-ios-quick-start://spotify-login-callback")!
        
    var accessToken: String? = nil
    
    @Published var currentSong = Track(name: "Test name", artist: "Test artist")
    @Published var isPaused = false
    @Published var playedSongs: Set<String> = Set<String>()
    private var previousSongUri = ""
    
    var playURI = ""
    
    private var connectCancellable: AnyCancellable?
    
    private var disconnectCancellable: AnyCancellable?
    
    override init() {
        super.init()
        connectCancellable = NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.connect()
            }
        
        disconnectCancellable = NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.disconnect()
            }

    }
        
    lazy var configuration = SPTConfiguration(
        clientID: SpotifySDK.clientId,
        redirectURL: spotifyRedirectURL
    )

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.connectionParameters.accessToken = self.accessToken
        appRemote.delegate = self
        return appRemote
    }()
    
    func setAccessToken(from url: URL) {
        let parameters = appRemote.authorizationParameters(from: url)
        
        if let accessToken = parameters?[SPTAppRemoteAccessTokenKey] {
            appRemote.connectionParameters.accessToken = accessToken
            self.accessToken = accessToken
        } else if let errorDescription = parameters?[SPTAppRemoteErrorDescriptionKey] {
            print(errorDescription)
        }
        
    }
    
    func connect() {
        guard let _ = self.appRemote.connectionParameters.accessToken else {
            self.appRemote.authorizeAndPlayURI("")
            return
        }
        
        appRemote.connect()
    }
    
    func disconnect() {
        if appRemote.isConnected {
            appRemote.disconnect()
        }
    }
}

extension SpotifySDK: SPTAppRemoteDelegate {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        self.appRemote = appRemote
        self.appRemote.playerAPI?.delegate = self
        self.appRemote.playerAPI?.subscribe(toPlayerState: { (result, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
            
        })
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        print("failed")
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        print("disconnected")
    }
}

extension SpotifySDK: SPTAppRemotePlayerStateDelegate {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        currentSong.name = playerState.track.name
        currentSong.artist = playerState.track.artist.name
        isPaused = playerState.isPaused
        let uri = playerState.track.uri
        
        if (previousSongUri != uri && playedSongs.contains(playerState.track.uri)) {
            appRemote.playerAPI?.skip(toNext: nil)
        }
        previousSongUri = uri
        playedSongs.insert(playerState.track.uri)
        print(currentSong.name, currentSong.artist)
    }
}
