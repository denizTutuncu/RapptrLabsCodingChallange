//
//  WeakRefVirtualProxy.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/21/22.
//

import UIKit

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: ChatErrorView where T: ChatErrorView {
    func display(_ viewModel: ChatErrorViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: ChatLoadingView where T: ChatLoadingView {
    func display(_ viewModel: ChatLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: UserProfileImageView where T: UserProfileImageView, T.Image == UIImage {
    func display(_ model: UserProfileImageViewModel<UIImage>) {
        object?.display(model)
    }
}
