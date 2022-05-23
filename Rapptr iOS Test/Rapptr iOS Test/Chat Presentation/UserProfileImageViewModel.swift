//
//  UserProfileImageViewModel.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public struct UserProfileImageViewModel<Image> {
    public let username: String
    public let textMessage: String
    public let image: Image?
    public let isLoading: Bool
}
