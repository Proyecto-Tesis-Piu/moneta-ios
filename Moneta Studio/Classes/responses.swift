//
//  responses.swift
//  Moneta Studio
//
//  Created by Tony on 11/29/20.
//

import Foundation


struct LoginForm {
    var token: String
    var emailConfirmed: Bool
    
    init(json: [String: Any]) {
        token = json["token"] as? String ?? ""
        emailConfirmed = json["emailConfirmed"] as? Bool ?? false
    }
}
