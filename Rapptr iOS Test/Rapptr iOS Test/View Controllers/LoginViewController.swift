//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var client: LoginClient = LoginClient()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        login()
    }
    
    private func login() {
        let details = getUserDetails()
        
        if let email = details?.email, let password = details?.password {
            client.login(email: email, password: password, completion: { [weak self] message in
                switch message {
                case let .some(value):
                    DispatchQueue.main.async {
                        self?.showAlert(alertText: "Hooray!", alertMessage: value) { _ in
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                case .none:
                    DispatchQueue.main.async {
                        self?.showAlert(alertText: "Something went wrong!", alertMessage: "Please double check your email address and password!")
                    }
                }
            })
        } else {
            
            DispatchQueue.main.async {
                self.showAlert(alertText: "Please provide your email address and password.", alertMessage: "Please try it again.")
            }
        }
    }
    
    private func getUserDetails() -> (email: String, password: String)? {
        guard let userEmailAddress = emailAddressTextField.text, !userEmailAddress.isEmpty, let userPassword = passwordTextField.text, !userPassword.isEmpty else { return nil }
        return (userEmailAddress, userPassword)
    }
}
