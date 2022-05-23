//
//  ChatPresenter.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public protocol ChatView {
    func display(_ viewModel: ChatViewModel)
}

public protocol ChatLoadingView {
    func display(_ viewModel: ChatLoadingViewModel)
}

public protocol ChatErrorView {
    func display(_ viewModel: ChatErrorViewModel)
}

public final class ChatPresenter {
    
    private let chatView: ChatView
    private let loadingView: ChatLoadingView
    private let errorView: ChatErrorView
    
    private var chatLoadError: String {
        return NSLocalizedString("CHAT_VIEW_CONNECTION_ERROR",
                                 tableName: "Chat",
                                 bundle: Bundle(for: ChatPresenter.self),
                                 comment: "Error message displayed when we can't load the image feed from the server")
    }
    
    public init(chatView: ChatView, loadingView: ChatLoadingView, errorView: ChatErrorView) {
        self.chatView = chatView
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    public static var title: String {
        return NSLocalizedString("CHAT_VIEW_TITLE", tableName: "Chat", bundle: Bundle(for: ChatPresenter.self), comment: "Title for the chat view")
    }
    
    public func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(ChatLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoadingFeed(with messages: [Message]) {
        chatView.display(ChatViewModel(messages: messages))
        loadingView.display(ChatLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        errorView.display(.error(message: chatLoadError))
        loadingView.display(ChatLoadingViewModel(isLoading: false))
    }
}
