//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
 */

class LoginClient {
    
    var session: URLSession?
    
    func login(email: String, password: String, completion: @escaping (String?) -> Void) {
        
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        
        let urlAsString = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
        
        guard let url = URL(string: urlAsString) else {
            //completion("")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let str = "email=\(email)&password=\(password)"
        let data = str.data(using: .utf8)
        request.httpBody = data
        
        session?.dataTask(with: request) { [weak self] data, _, error in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                switch self?.isError(errorCode: loginResponse.code) {
                case true:
                    completion(nil)                   
                case false:
                    completion(loginResponse.message)
                default:
                    completion(nil)
                }
                
            } catch {
                completion(nil)
            }
            
        }.resume()
        
    }
    
    private func isError(errorCode: String) -> Bool {
        guard !errorCode.isEmpty else { return true }
        if errorCode == "Error" {
            return true
        } else {
            return false
        }
    }
}

