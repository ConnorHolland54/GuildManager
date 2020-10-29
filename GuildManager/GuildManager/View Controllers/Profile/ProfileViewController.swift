//
//  ProfileViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/19/20.
//

import UIKit
import SideMenu
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var menu: SideMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuSetup()
        PlayerController.shared.fetchCurrentPlayer()
//        print(PlayerController.shared.currentPlayer)
//        GuildController.shared.fetchGuilds()
//        print("Guilds: \(GuildController.shared.guilds)")

        GuildController.shared.fetchGuildsWith(uid: Auth.auth().currentUser!.uid) { (success) in
            if success {
                print("Fetched")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func sideMenuSetup() {
        menu = SideMenu(rootViewController: UIViewController())
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
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
