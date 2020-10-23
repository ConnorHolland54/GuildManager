//
//  PlayerListViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/20/20.
//

import UIKit

class PlayerListViewController: UIViewController {

    @IBOutlet weak var playerListTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerListTableView.delegate = self
        playerListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PlayerController.shared.fetchAllPlayers { (succes) in
            if succes {
                print("Players count: \(PlayerController.shared.players.count)")
                DispatchQueue.main.async {
                    self.playerListTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlayerController.shared.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerListTableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let player = PlayerController.shared.players[indexPath.row]
        cell.textLabel?.text = "Name: \(player.name)"
        cell.detailTextLabel?.text = "Current Guild: \(player.currentGuild ?? "N/A")"
        return cell
    }
    
}
