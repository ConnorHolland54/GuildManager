//
//  Player.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import Foundation

struct Player: Codable {
    var name: String
    var alliance: String?
    var currentGuild: String?
    var homeGuild: String?
    let uid: String
}
