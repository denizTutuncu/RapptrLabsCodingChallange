//
//  ChatViewAdapter.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import UIKit

final class ChatViewAdapter: ChatView {
    private weak var controller: NewChatViewController?
    private let imageLoader: UserProfileImageDataLoader
    
    init(controller: NewChatViewController, imageLoader: UserProfileImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: ChatViewModel) {
        controller?.tableModel = viewModel.messages.map { model in
            let adapter = UserProfileImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<ChatProfileImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
            let view = ChatProfileImageCellController(delegate: adapter)
            
            adapter.presenter = UserProfileImagePresenter(
                view: WeakRefVirtualProxy(view),
                imageTransformer: UIImage.init)
            
            return view
        }
    }
}
