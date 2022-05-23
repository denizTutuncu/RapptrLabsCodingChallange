//
//  UserProfileImageClient.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import Foundation

public final class UserProfileImageClient {
    private let loader: UserProfileImageDataLoader
    
    public init(loader: UserProfileImageDataLoader) {
        self.loader = loader
    }
    
    public func fetchUserProfileImage(url: URL?, completion: @escaping (Data?,Error?) -> Void) -> UserProfileImageDataLoadeTask? {
        guard let url = url else { completion(nil, NSError()); return nil}
        let task = loader.loadImageData(from: url) { result in
            switch result {
            case let .success(imageData):
                completion(imageData, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
        return task
    }
}

extension RemoteImageLoader: UserProfileImageDataLoader {}
