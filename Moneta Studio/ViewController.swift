//
//  ViewController.swift
//  Moneta Studio
//
//  Created by Tony on 11/28/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyles()
    }
    
    func setupStyles() {
        loginButton.layer.cornerRadius = 5
    }
    

    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        NetworkManager.sharedInstance.postLogin(email, password) { (result, message) in
            if result  {
                print("logged in", message as! LoginForm)
            } else {
                print("login in failed", message as! String)
            }
        }
    }
    
}

