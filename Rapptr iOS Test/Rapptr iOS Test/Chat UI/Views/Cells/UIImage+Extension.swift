//
//  UIImage+Extension.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/16/22.
//

import UIKit

extension UIView {

    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
