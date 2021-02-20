//
//  ViewController.swift
//  Moneta Studio
//
//  Created by Tony on 11/28/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var goToRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyles()
    }
    
    func setupStyles() {
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Iniciar Sesión", for: .normal)
        goToRegister.setTitle("Olvidaste la contraseña", for: .normal)
    }
    

    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        NetworkManager.sharedInstance.postLogin(email, password) { (result, message) in
            if result  {
                if let login = message as? LoginForm {
                    print("logged in", login.token)
                    if login.emailConfirmed {
                        print("email confirmed")
                    } else {
                        print("confirma tu email pls ")
                    }
                }
            } else {
                print("login in failed", message as! String)
            }
        }
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
//        vc!.modalPresentationStyle = .fullScreen
//        present(vc!, animated: true)
    }
    
}

