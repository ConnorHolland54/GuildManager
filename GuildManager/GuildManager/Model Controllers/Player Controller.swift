//
//  Player Controller.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class PlayerController {
    
    static let shared = PlayerController()
    
    // MARK: - Sources of truth
    let db = Firestore.firestore().collection("Players")
    var currentPlayer: Player?
    var players: [Player] = []
    
    // MARK: - CRUD Methods
    //Create
    func createPlayerWith(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                print("Created User")
                
                if let uid = Auth.auth().currentUser?.uid {
                    let playerDict: [String: Any] = [
                        StringConstants.name: name,
                        StringConstants.alliance: "",
                        StringConstants.homeGuild: "",
                        StringConstants.currentGuild: ""
                    ]
                    self.db.document(uid).setData(playerDict)
                    
                    Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                        if let err = err {
                            print(err.localizedDescription)
                        } else {
                            print("Signed In")
                            
                        }
                    }
                }
            }
        }
    }
    
    //Update
    
    
    //Read
    func fetchCurrentPlayer() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let user = db.document(uid)
        user.getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                let result = Result {
                    try snapshot?.data(as: Player.self)
                }
                
                switch result {
                case .success(let user):
                    self.currentPlayer = user
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func fetchAllPlayers() {
        players = []
        db.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                for document in snapshot!.documents {
                    let result = Result {
                        try document.data(as: Player.self)
                    }
                    
                    switch result {
                    case .success(let player):
                        if let player = player {
                            self.players.append(player)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }
    
    //Delete
    
}
