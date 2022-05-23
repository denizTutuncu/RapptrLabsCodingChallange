//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coding Tasks"
    }
    
    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewControler = createChatViewController()
        navigationController?.pushViewController(chatViewControler, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
    
    private func createChatViewController() -> NewChatViewController {
        let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php")
        
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let remoteChatLoader = RemoteLoader(url: url, client: httpClient, mapper: ChatItemsMapper.map)
        let remoteImageLoader = RemoteImageLoader(client: httpClient)
        
        let chatViewControler = ChatUIComposer.chatComposedWith(chatLoader: remoteChatLoader, imageLoader: remoteImageLoader)
        return chatViewControler
    }
}
