//
//  NetworkManager.swift
//  Moneta Studio
//
//  Created by Tony on 11/28/20.
//

import Foundation
import Alamofire

class NetworkManager {
    
    var baseURL = "https://monetaapi.azurewebsites.net/api"
    var headers: HTTPHeaders = [
        "Accept":"*/*",
        "Content-Type":"application/json"
    ]
    
    static var sharedInstance = NetworkManager()
    private let sessionManager: Session
    
    required init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.httpAdditionalHeaders?.updateValue("applicatiion/json", forKey: "Accept")
        sessionManager = Session(configuration: configuration)
    }
    
    func setAuthToken(_ token: String) {
        headers["Authorization"] = "Bearer \(token)"
        headers["Content-Type"] = "application/json"
    }
    
    func removeAuthToken() {
        headers["Content-Type"] = "application/json"
    }
    
    func postLogin(_ email: String, _ password: String, completitionHandler: @escaping (Bool, Any?) -> Void) {
        let url = URL(string: baseURL + "/User/Login")
//        let parameters: [String: String] = ["email": email,
//                          "password": password]
        let parameters: [String: String] = ["email": "raul@outlook.com",
                          "password": "12345678"]
        
        sessionManager.request(url!, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let data = value as? [String: Any] else {
                    completitionHandler(false, value)
                    return
                }
                let loginResponse = LoginForm(json: data)
                self.setAuthToken(loginResponse.token)
                completitionHandler(true, loginResponse)
            case .failure:
                completitionHandler(false, "Communication Error.")
            }
        }
    }
}
