//
//  PlaylistsTableViewController.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/14/22.
//

import UIKit

class PlaylistsTableViewController: UITableViewController {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PlaylistController.shared.loadFromPersistanceStore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    //MARK: - Actions
    //CREATE PLAYLIST ACTION
    @IBAction func createPlaylistAction(_ sender: Any) {
        //create an alert controller
        let ac = UIAlertController(title: "New Playlist", message: "What would you like to name this playlist", preferredStyle: .alert)
        //added a textfield to that controller
        ac.addTextField { field in
            field.placeholder = "Playlist Name"
        }
        //Delcare our "add" action
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            //handler of our action, we do 2 things,
            //1. Extract the text from our textfield
            //2. Ensure our playlist name is not empty
            if let playlistName = ac.textFields?.first?.text, !playlistName.isEmpty {
                //finally we create our playlist
            PlaylistController.shared.createPlaylist(nameOfPlaylist: playlistName)
                self.tableView.reloadData()
            }
        }
        //Declare our "cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            //add our actions to the alert controller
        ac.addAction(addAction)
        ac.addAction(cancelAction)
            //finally present the alert controller
        self.present(ac, animated: true)
    }
    
    //MARK: - Helper Functions
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)

        // Configure the cell...
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.songs.count) songs"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist: playlistToDelete)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //Identifier Index Destination Object O
        if segue.identifier == "toSongList" {
            guard let index = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongTableViewController else { return }
            
            let playlistToSend = PlaylistController.shared.playlists[index.row]
            destination.playlist = playlistToSend
        }
    }

}
