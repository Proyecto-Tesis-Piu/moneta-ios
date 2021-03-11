//
//  AuthenticationManager.swift
//  Moneta Studio
//
//  Created by Tony on 2/14/21.
//

import Foundation
import UIKit

class AuthenticationManager {
    
    enum AuthenticationError: Error {
        case noCredentials
    }
    
    static let tokenKey = "login-token"
    static let userKey = "current-user"
    
    var isLoggedIn = false
    
    static private var _currentSession = false
    static var isCurrentSessionAuthenticated: Bool {
        get {
            return _currentSession
        }
        set {
            _currentSession = newValue
        }
    }
    
    static var currentToken: String? {
        get {
            guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
                return nil
            }
            return token
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tokenKey)
        }
    }
    
    static var currentUser: String? {
        get {
            guard let user = UserDefaults.standard.string(forKey: userKey) else {
                return nil
            }
            return user
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userKey)
        }
    }
    
//    static var deviceID: String {
//        get {
//            guard let subscription = OneSignal.getDeviceState(), subscription.isSubscribed else {
//                return ""
//            }
//            return subscription.userId!
//        }
//    }
    
    static let sharedInstance = AuthenticationManager()
    
    required init() {
        
    }
    
    func isLoggedIn(completion: @escaping (Bool) -> Void) {
        guard let token = AuthenticationManager.currentToken else {
            // We don't have a token stored so we need to ask for credentials
            completion(false)
            return
        }
        NetworkManager.sharedInstance.setAuthToken(token)
    }
}
