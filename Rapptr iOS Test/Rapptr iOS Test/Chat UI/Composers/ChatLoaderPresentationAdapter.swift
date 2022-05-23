//
//  ChatLoaderPresentationAdapter.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

final class ChatLoaderPresentationAdapter: ChatViewControllerDelegate {

    private let chatLoader: ChatLoader
    var presenter: ChatPresenter?
    
    init(chatLoader: ChatLoader) {
        self.chatLoader = chatLoader
    }
    
    func didRequestChatRefresh() {
        presenter?.didStartLoadingFeed()
        
        chatLoader.load { [weak self] result in
            switch result {
            case let .success(chat):
                self?.presenter?.didFinishLoadingFeed(with: chat)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingFeed(with: error)
            }
        }
    }
    
}
