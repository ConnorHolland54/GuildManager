//
//  RequestsTableViewCell.swift
//  GuildManager
//
//  Created by Connor Holland on 10/27/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol ReloadDelegate {
    func refresh()
}

class RequestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    var tableViewRefreshDelegate: ReloadDelegate!
    
    var player: Player? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        if let player = player {
            nameLabel.text = player.name
        }
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        guard let player = player else {return}
        acceptButton.setTitle("Accepted", for: .normal)
        GuildController.shared.updateRequestAndMembers(uid: player.uid, player: player)
        acceptButton.isEnabled = false
//        PlayerController.shared.updateCurrentGuild(player: player)
        GuildController.shared.fetchMembers(guildName: GuildController.shared.selectedGuildName!)
        tableViewRefreshDelegate.refresh()
    }
    
    

}
