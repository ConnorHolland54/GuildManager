//
//  MyGuildDetailViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/27/20.
//

import UIKit

class MyGuildDetailViewController: UIViewController {
    
    
    static let shared = MyGuildDetailViewController()
    var guild: Guild?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let name = guild?.guildName else {return}
        GuildController.shared.selectedGuildName = guild?.guildName
//        GuildController.shared.fetchRequestsFor(guildName: name)
        
        //test
        GuildController.shared.fetchRequestsFor(guildName: name)
        GuildController.shared.fetchMembers()
        
        
        print(GuildController.shared.members.count)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func memberButtonTapped(_ sender: Any) {
        guard let name = GuildController.shared.selectedGuildName else {return}
        print("Hit")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toRequests" {
            guard let destination = segue.destination as? RequestsTableViewCell else {return}
//            destination.guild = guild
        }
    }
    

}
