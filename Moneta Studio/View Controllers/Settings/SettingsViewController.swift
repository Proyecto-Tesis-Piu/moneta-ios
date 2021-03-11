//
//  SettingsViewController.swift
//  Moneta Studio
//
//  Created by Tony on 2/14/21.
//

import UIKit
import Auth0

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logout(_ sender: Any) {
        Auth0
            .webAuth()
            .clearSession(federated: false) { result in
                if result {
                    NetworkManager.sharedInstance.removeAuthToken()
                    AuthenticationManager.currentToken = nil
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let delegate = windowScene.delegate as? SceneDelegate else { return }
                    delegate.showAuth()
                    // Session cleared
                }
            }
    }
    
}
