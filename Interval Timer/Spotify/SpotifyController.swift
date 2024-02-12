//
//  SpotifyController.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/8/24. Followed: https://github.com/Peter-Schorn/SpotifyAPIExampleApp
//

import Foundation
import Combine
import UIKit
import SwiftUI
import KeychainAccess
import SpotifyWebAPI

final class SpotifyController: ObservableObject {
    
    private static let clientId: String = {
        if let clientId = ProcessInfo.processInfo
                .environment["CLIENT_ID"] {
            return clientId
        }
        fatalError("Could not find 'CLIENT_ID' in environment variables")
    }()
    
    private static let clientSecret: String = {
        if let clientSecret = ProcessInfo.processInfo
                .environment["CLIENT_SECRET"] {
            return clientSecret
        }
        fatalError("Could not find 'CLIENT_SECRET' in environment variables")
    }()
  
    let authorizationManagerKey = "authorizationManager"
    
    let loginCallbackURL = URL(
        string: "interval-timer-login://web-callback"
    )!
    
    var authorizationState = String.randomURLSafe(length: 128)
    
    @Published var isAuthorized = false
    
    let keychain = Keychain(service: "com.TripleC.Interval-Timer")
    
    let api = SpotifyAPI(
        authorizationManager: AuthorizationCodeFlowManager(
            clientId: SpotifyController.clientId,
            clientSecret: SpotifyController.clientSecret
        )
    )
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        
        self.api.apiRequestLogger.logLevel = .trace
   
        self.api.authorizationManagerDidChange
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidChange)
            .store(in: &cancellables)
        
        self.api.authorizationManagerDidDeauthorize
            .receive(on: RunLoop.main)
            .sink(receiveValue: authorizationManagerDidDeauthorize)
            .store(in: &cancellables)
        
        if let authManagerData = keychain[data: self.authorizationManagerKey] {
            
            do {
                let authorizationManager = try JSONDecoder().decode(
                    AuthorizationCodeFlowManager.self,
                    from: authManagerData
                )
                print("found authorization information in keychain")
                
                self.api.authorizationManager = authorizationManager
                
            } catch {
                print("could not decode authorizationManager from data:\n\(error)")
            }
        }
        else {
            print("did NOT find authorization information in keychain")
        }
        
    }
    
    func authorize() {
        
        let url = self.api.authorizationManager.makeAuthorizationURL(
            redirectURI: self.loginCallbackURL,
            showDialog: true,
            state: self.authorizationState,
            scopes: [
                .userReadPlaybackState,
                .userModifyPlaybackState,
                .playlistReadPrivate,
                .playlistReadCollaborative,
                .userReadCurrentlyPlaying
            ]
        )!
        
        UIApplication.shared.open(url)
        
    }
    
    func authorizationManagerDidChange() {
        
        self.isAuthorized = self.api.authorizationManager.isAuthorized()
        
        print(
            "Spotify.authorizationManagerDidChange: isAuthorized:",
            self.isAuthorized
        )
        
        do {
            // Encode the authorization information to data.
            let authManagerData = try JSONEncoder().encode(
                self.api.authorizationManager
            )
            
            // Save the data to the keychain.
            self.keychain[data: self.authorizationManagerKey] = authManagerData
            print("did save authorization manager to keychain")
            
        } catch {
            print(
                "couldn't encode authorizationManager for storage " +
                    "in keychain:\n\(error)"
            )
        }
        
    }
    
    func authorizationManagerDidDeauthorize() {
        self.isAuthorized = false
        
        do {
            try self.keychain.remove(self.authorizationManagerKey)
            print("did remove authorization manager from keychain")
            
        } catch {
            print(
                "couldn't remove authorization manager " +
                "from keychain: \(error)"
            )
        }
    }
}
