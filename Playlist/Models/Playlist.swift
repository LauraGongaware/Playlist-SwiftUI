//
//  Playlist.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/14/22.
//

import Foundation

class Playlist: Codable {
    //MARK: - Properties
    let name: String
    var songs: [Song]
    
    //MARK: - Convinience Initializer
    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }
}

extension Playlist: Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.name == rhs.name && lhs.songs == rhs.songs
    }
}
