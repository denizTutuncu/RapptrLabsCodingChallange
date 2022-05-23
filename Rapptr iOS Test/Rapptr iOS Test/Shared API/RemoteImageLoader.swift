//
//  RemoteImageLoader.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public final class RemoteImageLoader {
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    private final class HTTPClientTaskWrapper: UserProfileImageDataLoadeTask {
        private var completion: ((UserProfileImageDataLoader.Result) -> Void)?
        
        var wrapped: HTTPClientTask?
        
        init(_ completion: @escaping (UserProfileImageDataLoader.Result) -> Void) {
            self.completion = completion
        }
        
        func complete(with result: UserProfileImageDataLoader.Result) {
            completion?(result)
        }
        
        func cancel() {
            preventFurtherCompletions()
            wrapped?.cancel()
        }
        
        private func preventFurtherCompletions() {
            completion = nil
        }
    }
    
    
    public func loadImageData(from url: URL, completion: @escaping (UserProfileImageDataLoader.Result) -> Void) -> UserProfileImageDataLoadeTask {
        let task = HTTPClientTaskWrapper(completion)
        task.wrapped = client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            task.complete(with: result
                            .mapError { _ in Error.connectivity }
                            .flatMap { (data, response) in
                                let isValidResponse = response.isOK && !data.isEmpty
                                return isValidResponse ? .success(data) : .failure(Error.invalidData)
                            })
            
        }
        return task
    }
}
