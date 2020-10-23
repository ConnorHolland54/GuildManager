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
    var myGuilds: [Guild] = []
    
    
    // MARK: - CRUD Methods
    //Create
    func createGuild(name: String) {
        let user = PlayerController.shared.currentPlayer!
        
        let guildDict: [String: Any] = [
            StringConstants.guildName: name,
            StringConstants.guildManager: user.uid,
            StringConstants.guildLeadership: [user.uid]
        ]
        db.document(name).setData(guildDict)
    }
    
    
    
    //Read
    func fetchGuilds(completion: @escaping (Bool) -> Void) {
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
            completion(!self.guilds.isEmpty)
        }
    }
    
    func fetchGuildsWith(uid: String) {
        let query = db.whereField(StringConstants.guildManager, isEqualTo: uid)
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                for document in snapshot!.documents {
                    let result = Result {
                        try document.data(as: Guild.self)
                    }
                    
                    switch result {
                    case .success(let guild):
                        if let guild = guild {
                            self.myGuilds.append(guild)
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
    
    
    // Checks if user already requested to join guild
    func requestCheck(guildName: String, uid: String) {
        db.document(guildName).collection("Requests").document(uid).getDocument { (document, err) in
            if let document = document, document.exists {
                print("Exists")
            } else {
                self.memberCheck(guildName: guildName, uid: uid)
            }
        }
    }

    func memberCheck(guildName: String, uid: String) {
        db.document(guildName).collection("Members").document(uid).getDocument { (document, err) in
            if let document = document, document.exists {
                print("Exists")
            } else {
                print("Does not exist")
                self.db.document(guildName).collection("Requests").document(uid).setData([StringConstants.uid: uid])
            }
        }
    }
    
    
}
