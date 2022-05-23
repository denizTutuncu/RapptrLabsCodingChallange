//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

extension AnimationViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let centerPoint = session.location(in: self.view)
        if session.location(in: self.view).y <= self.logoImageView.frame.maxY {
            guard let image = logoImageView.image else { return [] }
            let provider = NSItemProvider(object: image)
            let item = UIDragItem(itemProvider: provider)
            self.logoImageView.center = centerPoint
            return [item]
        } else {
            guard let image = secondImaegView.image else { return [] }
            let provider = NSItemProvider(object: image)
            let item = UIDragItem(itemProvider: provider)
            self.secondImaegView.center = centerPoint
            return [item]
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for dragItem in session.items {
            dragItem.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { object, error in
                guard error == nil else { return print("Failed to load our dragged item") }
                guard let draggedImage = object as? UIImage else { return }
                
                DispatchQueue.main.async {
                    let centerPoint = session.location(in: self.view)
                    if session.location(in: self.view).y <= self.logoImageView.frame.maxY {
                        self.logoImageView.image = draggedImage
                        self.logoImageView.center = centerPoint
                    } else {
                        self.secondImaegView.image = draggedImage
                        self.secondImaegView.center = centerPoint
                    }
                }
            })
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    private func addDragInteraction() {
        view.addInteraction(UIDragInteraction(delegate: self))
    }
    
    private func addDropInteraction() {
        view.addInteraction(UIDropInteraction(delegate: self))
    }
    
    private func enableUserInteractionTo(image: UIImageView?) {
        guard let image = image else { return }
        image.isUserInteractionEnabled = true
    }
    
    private func disableUserInteractionFrom(image: UIImageView?) {
        guard let image = image else { return }
        image.isUserInteractionEnabled = false
    }
    
    private func addInteractionToImages() {
        let logoImage = logoImageView
        enableUserInteractionTo(image: logoImage)
        let secondImage = secondImaegView
        enableUserInteractionTo(image: secondImage)
    }
    
    private func stopInteractionFromImages() {
        let logoImage = logoImageView
        disableUserInteractionFrom(image: logoImage)
        let secondImage = secondImaegView
        disableUserInteractionFrom(image: secondImage)
    }
}

class AnimationViewController: UIViewController {
    private var fadeState = false
    
    @IBOutlet weak var fadeButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var secondImaegView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        setButtonTitle(isFadeIn: fadeState)
        addDragInteraction()
        addDropInteraction()
    }
    
    // MARK: - Actions
    @IBAction func didPressFade(_ sender: Any) {
        switchState()
        setButtonTitle(isFadeIn: fadeState)
    }
    
    private func switchState() {
        switch fadeState {
        case true:
            fadeOut()
        case false:
            fadeIn()
        }
    }

    private func fadeIn() {
        guard let image = UIImage(named: "ic_logo") else { return }
        logoImageView.image = image
        logoImageView.fadeIn()
        fadeState.toggle()
        addInteractionToImages()
    }
    
    private func fadeOut() {
        logoImageView.fadeOut()
        secondImaegView.fadeOut()
        fadeState.toggle()
        stopInteractionFromImages()
    }
    
    private func setButtonTitle(isFadeIn: Bool) {
        switch isFadeIn {
        case true:
            fadeButton.setTitle("FADE OUT", for: .normal)
        case false:
            fadeButton.setTitle("FADE IN", for: .normal)
        }
    }
}
