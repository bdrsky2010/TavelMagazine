//
//  ChttingRoomViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    public var chatRoom: ChatRoom?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
    }
    

    

}

extension ChattingRoomViewController: ConfigureViewControllerProtocol {
    
    func configureNavigation() {
        
        navigationItem.title = chatRoom?.chatroomName
        navigationController?.navigationBar.tintColor = .label
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    private func leftBarButtonAction() {
        
        navigationController?.popViewController(animated: true)
    }
}
