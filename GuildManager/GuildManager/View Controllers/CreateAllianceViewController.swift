//
//  CreateAllianceViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/20/20.
//

import UIKit

class CreateAllianceViewController: UIViewController {

    @IBOutlet weak var aliianceNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
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
