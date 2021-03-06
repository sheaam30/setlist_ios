//
//  ViewController.swift
//  Set List
//
//  Created by Adam Shea on 12/9/17.
//  Copyright © 2017 Adam Shea. All rights reserved.
//

import UIKit

class SongListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var setList:SetList?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSong))
        self.navigationItem.rightBarButtonItem = addButton
//        self.navigationItem.leftBarButtonItem = editButtonItem
        
        setupData()
        self.title = setList?.name
    }

    func setupData() {
        
        let song:Song = Song(songName: "Name", artist: "Artist", genre: "Genre", setList: SetList(name: "List"))
        setList?.songs.append(song)
        setList?.songs.append(song)
        setList?.songs.append(song)
        setList?.songs.append(song)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((setList?.songs.count))!
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        cell?.nameLabel.text = (setList?.songs[indexPath.row].song!)! + indexPath.row.description
        cell?.artistLabel.text = (setList?.songs[indexPath.row].artist!)! + indexPath.row.description
        
        return cell!
        
    }
    
    @objc func addSong() {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addSong()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        UserDefaults.standard.set(setList, forKey: "setlist")
        UserDefaults.standard.synchronize()
    }
    
    func load() {
        if let setListData = UserDefaults.standard.value(forKey: "setlist") as? SetList        {
            setList = setListData
            tableView.reloadData()
        }
    }
}

