//
//  ChatItemsMapper.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/16/22.
//

import Foundation
 
public final class ChatItemsMapper {
    
    private struct Root: Decodable {
        private let data: [RemoteChatItem]
        
        private struct RemoteChatItem: Decodable {
            internal let user_id: String
            internal let name: String
            internal let avatar_url: URL?
            internal let message: String
        }
        
        var messages: [Message] {
            data.map { Message(userID: $0.user_id, username: $0.name, avatarURL: $0.avatar_url, withTestMessage: $0.message) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Message] {
        guard isOK(response),
              let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.messages
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
    
}
