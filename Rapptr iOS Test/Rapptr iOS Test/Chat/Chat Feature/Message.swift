//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

public struct Message {
    public var userID: String
    public var username: String
    public var avatarURL: URL?
    public var text: String
    
    public init(userID: String, username: String, avatarURL: URL?, withTestMessage text: String) {
        self.userID = userID
        self.username = username
        self.avatarURL = avatarURL
        self.text = text
    }
}
