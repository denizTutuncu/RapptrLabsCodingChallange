//
//  UserProfileImagePresenter.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import Foundation

public protocol UserProfileImageView {
    associatedtype Image
    func display(_ model: UserProfileImageViewModel<Image>)
}

public final class UserProfileImagePresenter<View: UserProfileImageView, Image> where View.Image == Image {
    private let view: View
    private let imageTransformer: (Data) -> Image?
    
    public init(view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.view = view
        self.imageTransformer = imageTransformer
    }
    
    public func didStartLoadingImageData(for model: Message) {
        view.display(UserProfileImageViewModel(username: model.username, textMessage: model.text, image: nil, isLoading: true))
    }
    
    public func didFinishLoadingImageData(with data: Data, for model: Message) {
        let image = imageTransformer(data)
        view.display(UserProfileImageViewModel(username: model.username, textMessage: model.text, image: image, isLoading: false))
    }
    
    public func didFinishLoadingImageData(with error: Error, for model: Message) {
        view.display(UserProfileImageViewModel(username: model.username, textMessage: model.text, image: nil, isLoading: false))
    }
}
