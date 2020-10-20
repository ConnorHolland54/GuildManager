//
//  GuildController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class GuildController {
    
    static let shared = GuildController()
    
    let db = Firestore.firestore().collection("Guilds")
    
    var guilds: [Guild] = []
    
    
    // MARK: - CRUD Methods
    //Create
    func createGuild(name: String) {
        let user = PlayerController.shared.currentPlayer!
        
        let guildDict: [String: Any] = [
            StringConstants.guildName: name,
            StringConstants.guildManager: user.uid,
            StringConstants.guildLeadership: [user.uid],
            StringConstants.members: []
        ]
        db.document(name).setData(guildDict)
    }
    
    
    
    //Read
    func fetchGuilds() {
        guilds = []
        db.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                for document in snapshot!.documents {
                    
                    let result = Result {
                        try document.data(as: Guild.self)
                    }
                    
                    switch result {
                    case .success(let fetchedGuild):
                        if let guild = fetchedGuild {
                            self.guilds.append(guild)
                            print(guild)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    
    //Update
    //Delete
    
    
    
}
