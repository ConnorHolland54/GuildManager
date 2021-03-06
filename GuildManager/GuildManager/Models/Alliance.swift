//
//  Alliance.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import Foundation

struct Alliance: Codable {
    var allianceName: String
    var allianceLeadership: [Player]
    var guilds: [Guild]
}
