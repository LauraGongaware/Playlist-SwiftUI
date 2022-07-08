//
//  Song.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/13/22.
//

import Foundation

class Song: Codable {
    let title: String
    let artist: String
    let uuid: String  //universally unique identfier
    
    init(title:String, artist: String, uuid: String = UUID().uuidString) {
        self.title = title
        self.artist = artist
        self.uuid = uuid
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
//        return rhs.title == lhs.title && rhs.artist == lhs.artist
        return rhs.uuid == lhs.uuid
    }
    
}
