//
//  GuildListTableViewCell.swift
//  GuildManager
//
//  Created by Connor Holland on 10/23/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol ReloadDataDelegate {
    func refreshTable()
}


class GuildListTableViewCell: UITableViewCell {


    @IBOutlet weak var guildNameLabel: UILabel!
    @IBOutlet weak var guildGMLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    
    let db = Firestore.firestore().collection("Guilds")
    
    var guild: Guild? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let user = Auth.auth().currentUser else {return}
        if let guild = guild {
            PlayerController.shared.fetchPlayerWith(uid: guild.guildManager) { (result) in
                switch result {
                case .success(let player):
                    self.guildGMLabel.text = "GM: \(player.name)"
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            guildNameLabel.text = "Name: \(guild.guildName)"
            requested(guildName: guild.guildName, uid: user.uid)
        }
    }
    
    @IBAction func requestToJoinButtonTapped(_ sender: Any) {
        
        guard let guild = guild, let user = Auth.auth().currentUser else {return}
        if PlayerController.shared.currentPlayer?.currentGuild == nil {
            GuildController.shared.requestCheck(guildName: guild.guildName, uid: user.uid)
        } else {
            print("already in a guild")
        }
        joinButton.isEnabled = false
        joinButton.setTitle("Requested", for: .disabled)
    }
    

    // Checks if user already requested to join guild
    func requested(guildName: String, uid: String) {
        db.document(guildName).collection("Requests").document(uid).getDocument { (document, err) in
            if let document = document, document.exists {
                print("Exists")
                self.joinButton.isEnabled = false
                self.joinButton.setTitle("Requested", for: .disabled)
                
            } else {
                self.isMember(guildName: guildName, uid: uid)
            }
        }
    }
    
    func isMember(guildName: String, uid: String) {
        db.document(guildName).collection("Members").document(uid).getDocument { (document, err) in
            if let document = document, document.exists {
                print("Exists")
                self.joinButton.isEnabled = false
                self.joinButton.setTitle("Requested", for: .disabled)
            } else {
                print("Does not exist")
            }
        }
    }
    
    
    
    
}
