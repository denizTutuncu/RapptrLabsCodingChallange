//
//  ChatUIComposer.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import UIKit

public final class ChatUIComposer {
    private init() {}
    public static func chatComposedWith(chatLoader: ChatLoader, imageLoader:  UserProfileImageDataLoader) -> NewChatViewController {
        let presentationAdapter = ChatLoaderPresentationAdapter(chatLoader: MainQueueDispatchDecorator(decoratee: chatLoader))
        
        let chatController = makeChatViewController(delegate: presentationAdapter, title: ChatPresenter.title)
        
        presentationAdapter.presenter = ChatPresenter(
            chatView: ChatViewAdapter(controller: chatController,
                                      imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)),
            loadingView: WeakRefVirtualProxy(chatController), errorView: WeakRefVirtualProxy(chatController))
        
        return chatController
    }
    
    private static func makeChatViewController(delegate: ChatViewControllerDelegate, title: String) -> NewChatViewController {
        let bundle = Bundle(for: NewChatViewController.self)
        let storyboard = UIStoryboard(name: "Chat", bundle: bundle)
        let chatController = storyboard.instantiateInitialViewController() as! NewChatViewController
        chatController.delegate = delegate
        chatController.title = title
        return chatController
    }
}
