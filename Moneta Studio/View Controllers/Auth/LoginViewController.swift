//
//  ViewController.swift
//  Moneta Studio
//
//  Created by Tony on 11/28/20.
//

import UIKit
import Auth0

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
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://monetastudio.us.auth0.com/userinfo")
            .start { result in
                switch result {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    // Do something with credentials e.g.: save them.
                    // Auth0 will automatically dismiss the login page
//                    print("Credentials: \(credentials)", credentials.accessToken)
                    guard let token = credentials.accessToken else { return } //TODO: handle Error
                    NetworkManager.sharedInstance.setAuthToken(token)
                    AuthenticationManager.currentToken = token
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let delegate = windowScene.delegate as? SceneDelegate else { return }
                    delegate.showHome()
                }
        }
    }
    
    @IBAction func goToSignIn(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
//        vc!.modalPresentationStyle = .fullScreen
//        present(vc!, animated: true)
    }
    
}

