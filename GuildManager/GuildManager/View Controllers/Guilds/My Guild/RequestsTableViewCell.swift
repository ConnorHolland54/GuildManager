//
//  RequestsTableViewCell.swift
//  GuildManager
//
//  Created by Connor Holland on 10/27/20.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
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
    
    

}
