//
//  MyGuildsViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/20/20.
//

import UIKit

class MyGuildsViewController: UIViewController {

    @IBOutlet weak var myGuildsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGuildsTableView.delegate = self
        myGuildsTableView.dataSource = self
    }
    


    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "myGuildDetail" {
            guard let indexPath = myGuildsTableView.indexPathForSelectedRow, let destination = segue.destination as? MyGuildDetailViewController else {return}
            let itemToSend = GuildController.shared.myGuilds[indexPath.row]
            destination.guild = itemToSend
        }
    }


}

extension MyGuildsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuildController.shared.myGuilds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myGuildsTableView.dequeueReusableCell(withIdentifier: "myGuildCell", for: indexPath)
        let guild = GuildController.shared.myGuilds[indexPath.row]
        cell.textLabel?.text = guild.guildName
        cell.detailTextLabel?.text = "Members: count"
        return cell
    }
    
    
    
}