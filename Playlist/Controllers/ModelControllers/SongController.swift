//
//  SongController.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/13/22.
//

import Foundation

class SongController {
    
    //MARK: - CRUD Functions (create, read, update and delete)
    
    static func createSong(title:String, artist:String, playlist: Playlist) {
        let newSong = Song(title: title, artist: artist)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveToPersistanceStore()
    }
    
    static func deleteSong(song: Song, playlist: Playlist) {
        guard let index = playlist.songs.firstIndex(of: song) else {return}
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistanceStore()
    }
    
    //MARK: -- Date Persistance
    // Create a place to store our data, save the data, load the data
    
} // END OF CLASS
