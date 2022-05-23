//
//  UserProfileImageDataLoader.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/19/22.
//

import Foundation

public protocol UserProfileImageDataLoadeTask {
    func cancel()
}

public protocol UserProfileImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> UserProfileImageDataLoadeTask
}
