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
    func createPlayerWith(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
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
                        StringConstants.currentGuild: "",
                        StringConstants.uid: Auth.auth().currentUser!.uid
                    ]
                    self.db.document(uid).setData(playerDict)
                    
                    self.signIn(email: email, pass: password) { (success) in
                        return completion(success)
                    }
                    
                }
            }
        }
    }
    
    //Update
    
    
    //Read
    func fetchPlayerWith(uid: String, completion: @escaping (Result<Player,Error>) -> Void) {
        db.document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                let result = Result {
                    try snapshot?.data(as: Player.self)
                }
                
                switch result {
                case .success(let fetchedPlayer):
                    if let player = fetchedPlayer {
                        completion(.success(player))
                    }
                    
                case .failure(let err):
                    completion(.failure(err))
                } 
            }
        }
    }
    
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
                    if let player = user {
                        print(player)
                        self.currentPlayer = player
                        print(self.currentPlayer)
                    }
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
    
    
    // MARK: - Helper Methods
    func signIn(email: String, pass: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                print("Signed In")
                return completion(Auth.auth().currentUser?.uid != nil)
            }
        }
    }
}
