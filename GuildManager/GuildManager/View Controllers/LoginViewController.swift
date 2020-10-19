//
//  LoginViewController.swift
//  GuildManager
//
//  Created by Connor Holland on 10/18/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonSetup(num: 1)
    }
    
    // MARK: - Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        buttonSetup(num: 1)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        buttonSetup(num: 2)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        submit()
    }
    
    // MARK: - Helper Methods
    
    func submit() {
        if reenterPasswordTextField.isHidden == false {
            guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let passTwo = reenterPasswordTextField.text, !passTwo.isEmpty, let name = nameTextField.text, !name.isEmpty else {return}
            if password == passTwo {
                //create user
                PlayerController.shared.signIn(email: email, pass: password) { (success) in
                    if success {
                        self.performSegue(withIdentifier: "toProfile", sender: self)
                    }
                }
            } else {
                //error
            }
        } else {
            //sign in
            guard let email = emailTextField.text, !email.isEmpty, let pass = passwordTextField.text, !pass.isEmpty else {return}
            PlayerController.shared.signIn(email: email, pass: pass) { (success) in
                if success {
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                }
            }
        }
    }
    
    
    func buttonSetup(num: Int) {
        
        switch num {
        case 1:
            loginButton.isSelected = true
            SignUpButton.isSelected = false
            SignUpButton.setTitleColor(.white, for: .selected)
            reenterPasswordTextField.isHidden = true
            nameTextField.isHidden = true
        case 2:
            loginButton.isSelected = false
            SignUpButton.isSelected = true
            loginButton.setTitleColor(.white, for: .selected)
            reenterPasswordTextField.isHidden = false
            nameTextField.isHidden = false
        default:
            print("None")
        }
        
        
        
    }


} // End of class
