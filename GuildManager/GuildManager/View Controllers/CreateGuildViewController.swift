//
//  CreateGuildViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/19/20.
//

import UIKit

class CreateGuildViewController: UIViewController {

    @IBOutlet weak var guildNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        guard let name = guildNameTextField.text, !name.isEmpty else {return}
        GuildController.shared.createGuild(name: name)
        createdGuildAlert()
    }
    
    // MARK: - Helper Methods
    func createdGuildAlert() {
        let controller = UIAlertController(title: nil, message: "Successfully created the guild!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.guildNameTextField.text = ""
        }
        controller.addAction(okAction)
        present(controller, animated: true)
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
