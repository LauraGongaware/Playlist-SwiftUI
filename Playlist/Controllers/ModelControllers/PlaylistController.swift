//
//  PlaylistController.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/14/22.
//

import Foundation

class PlaylistController {
    
    //MARK: -- PROPERTIES
    static let shared = PlaylistController()
    //MARK: = Source of truth
    
    var playlists: [Playlist] = []
    
    //MARK: - CRUD Functions
    
    //Create
    func createPlaylist(nameOfPlaylist: String){
        let newPlaylist = Playlist(name: nameOfPlaylist)
        playlists.append(newPlaylist)
        saveToPersistanceStore()
    }
    
    //DELETE
    func deletePlaylist(playlist: Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: index)
        saveToPersistanceStore()
    }
    
    func createPersistanceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    func saveToPersistanceStore() {
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: createPersistanceStore())
            
        } catch {
            print("Error encoding our songs.")
        }
    }
    func loadFromPersistanceStore() {
        do {
            let data = try Data(contentsOf: createPersistanceStore())
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        }
        catch {
            print("Error decoding our data into songs")
        }
    }
}
