//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

public final class ChatClient {
    
    private let loader: ChatLoader
    
    public init(loader: ChatLoader) {
        self.loader = loader
    }
    
    public func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        loader.load { result in
            switch result {
            case let .success(messages):
                completion(messages)
                
            case .failure:
                completion([])
            }
        }
    }
}
extension RemoteLoader: ChatLoader where Resource == [Message] {}

