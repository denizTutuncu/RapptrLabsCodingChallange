//
//  HTTPURLResponse+StatusCode.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/16/22.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
