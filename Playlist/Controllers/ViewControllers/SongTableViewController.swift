//
//  SongTableViewController.swift
//  Playlist
//
//  Created by Laura Gongaware on 6/13/22.
//

import UIKit

class SongTableViewController: UITableViewController {
//MARK: -- Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    //landing pad
    var playlist: Playlist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        SongController.shared.loadFromPersistanceStore()
    }
    
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        
        guard let songTitle = songTitleTextField.text,
              !songTitle.isEmpty,
              let artistName = artistNameTextField.text,
              !artistName.isEmpty else { return }
        
//        SongController.shared.createSong(title: songTitle, artist: artistName)
        SongController.createSong(title: songTitle, artist: artistName, playlist: self.playlist)
        
        tableView.reloadData()
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        songTitleTextField.becomeFirstResponder()

    }
    
        

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return SongController.shared.songs.count
        return playlist.songs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
// Configure the cell...

        let song = playlist.songs[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelete, playlist: self.playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
