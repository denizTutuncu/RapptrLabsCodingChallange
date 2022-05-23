//
//  LoginResponse.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public struct LoginResponse: Decodable {
    public let code, message: String
    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}
