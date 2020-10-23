//
//  Guild.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import Foundation

struct Guild: Codable {
    var guildName: String
    var guildManager: String
    var guildLeadership: [String]
//    var members: [String]
}
