//
//  ChatErrorViewModel.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public struct ChatErrorViewModel {
    public let message: String?
    
    static var noError: ChatErrorViewModel {
        return ChatErrorViewModel(message: .none)
    }
    
    static func error(message: String) -> ChatErrorViewModel {
        return ChatErrorViewModel(message: message)
    }
}
