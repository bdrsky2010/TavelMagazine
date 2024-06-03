//
//  TravelTalkViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

final class TravelTalkViewController: UIViewController {

    @IBOutlet weak var userChattingRoomSearchBar: UISearchBar! {
        
        didSet {
            
            userChattingRoomSearchBar.delegate = self
        }
    }
    @IBOutlet weak var chattingRoomTableView: UITableView! {
        
        didSet {
            
            chattingRoomTableView.delegate = self
            chattingRoomTableView.dataSource = self
        }
    }
    
    private var chatRoomList = mockChatList {
        
        didSet {
            guard let text = userChattingRoomSearchBar.text else { return }
            
            searchChatRoom(query: text)
        }
    }
    
    private var filteredChatRoomList: [ChatRoom] = [] {
        
        didSet {
            chattingRoomTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "TRAVEL TALK"
        
        filteredChatRoomList = chatRoomList
        
        userChattingRoomSearchBar.placeholder = "친구의 이름을 검색해보세요"
        
        configureTableView()
    }
    
}

extension TravelTalkViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let chatRoom = filteredChatRoomList[index]
        
        let identifier = ChattingRoomViewController.identifier
        
        let chattingRoomViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! ChattingRoomViewController
        
        chattingRoomViewController.chatRoom = chatRoom
        
        chattingRoomViewController.delegate = self
        
        navigationController?.pushViewController(chattingRoomViewController, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension TravelTalkViewController: UITableViewDataSource {
    
    private func configureTableView() {
        
        let singleChatIdentifier = SingleChattingRoomTableViewCell.identifier
        let singleChatNib = UINib(nibName: singleChatIdentifier, bundle: nil)
        
        let multiChatIdentifier = MultiChattingRoomTableViewCell.identifier
        let multiChatNib = UINib(nibName: multiChatIdentifier, bundle: nil)
        
        chattingRoomTableView.register(singleChatNib, forCellReuseIdentifier: singleChatIdentifier)
        chattingRoomTableView.register(multiChatNib, forCellReuseIdentifier: multiChatIdentifier)
        
        chattingRoomTableView.rowHeight = 70
        chattingRoomTableView.separatorStyle = .none
        
        chattingRoomTableView.keyboardDismissMode = .onDrag
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChatRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let chatRoom = filteredChatRoomList[index]
        
        var identifier: String
        
        if chatRoom.chatroomImage.count > 1 {
            
            identifier = MultiChattingRoomTableViewCell.identifier
            
            let cell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MultiChattingRoomTableViewCell
            
            cell.configureContents(chatRoom)
            
            return cell
        }
        
        identifier = SingleChattingRoomTableViewCell.identifier
        
        let cell = chattingRoomTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SingleChattingRoomTableViewCell
        
        cell.configureContents(chatRoom)
        
        return cell
    }
}

extension TravelTalkViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchChatRoom(query: searchText)
    }
    
    private func searchChatRoom(query: String) {
        if query.isEmpty {
            
            filteredChatRoomList = chatRoomList
            
            return
        }
        
        filteredChatRoomList = chatRoomList.filter { $0.chatroomName.contains(query) }
    }
}

extension TravelTalkViewController: TravelTalkDelegate {
    
    public func sendMessage(_ chatRoom: ChatRoom) {
        
        for i in 0..<chatRoomList.count {
            
            if chatRoomList[i].chatroomId == chatRoom.chatroomId {
                chatRoomList[i] = chatRoom
            }
        }
    }
}
