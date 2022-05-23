//
//  UIViewController+Extension.swift
//  Rapptr iOS Test
//
//  Created by Deniz Tutuncu on 5/20/22.
//

import UIKit

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
