//
//  UserProfileImageDataLoaderPresentationAdapter.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import Foundation

final class UserProfileImageDataLoaderPresentationAdapter<View: UserProfileImageView, Image>: ChatProfileImageCellControllerDelegate where View.Image == Image {
    private let model: Message
    private let imageLoader: UserProfileImageDataLoader
    private var task: UserProfileImageDataLoadeTask?
    
    var presenter: UserProfileImagePresenter<View, Image>?
    
    init(model: Message, imageLoader: UserProfileImageDataLoader) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    func didRequestImage() {
        presenter?.didStartLoadingImageData(for: model)
        
        let model = self.model
        task = imageLoader.loadImageData(from: model.avatarURL ?? URL(string: "")!) { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter?.didFinishLoadingImageData(with: data, for: model)
                
            case let .failure(error):
                self?.presenter?.didFinishLoadingImageData(with: error, for: model)
            }
        }
    }
    
    func didCancelImageRequest() {
        task?.cancel()
    }
}
