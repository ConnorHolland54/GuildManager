//
//  GuildsViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/20/20.
//

import UIKit

class GuildsViewController: UIViewController {

    @IBOutlet weak var guildListTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guildListTableView.delegate = self
        guildListTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GuildController.shared.fetchGuilds { (success) in
            if success {
                self.guildListTableView.reloadData()
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

extension GuildsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuildController.shared.guilds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = guildListTableView.dequeueReusableCell(withIdentifier: "guildCell", for: indexPath) as? GuildListTableViewCell else {return UITableViewCell()}
        let guild = GuildController.shared.guilds[indexPath.row]
        cell.guild = guild
        
//        PlayerController.shared.fetchPlayerWith(uid: guild.guildManager) { (result) in
//            switch result {
//            case .success(let player):
//                cell.detailTextLabel?.text = "GM: \(player.name)"
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
     return cell
    }
    
    
    
}
