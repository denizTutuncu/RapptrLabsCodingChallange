//
//  MainQueueDispatchDecorator.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: ChatLoader where T == ChatLoader {
    func load(completion: @escaping (ChatLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: UserProfileImageDataLoader where T == UserProfileImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (UserProfileImageDataLoader.Result) -> Void) -> UserProfileImageDataLoadeTask {
        decoratee.loadImageData(from: url) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
