//
//  Playlist.swift
//  Interval Timer
//
//  Created by Clare Tuch on 2/8/24.
//

import Foundation

struct PlaylistInfo: Hashable, Codable {
    var name: String
    var uri: String
    var availableSongs: [String]?
    
    private enum CodingKeys: String, CodingKey { case name, uri }
}
