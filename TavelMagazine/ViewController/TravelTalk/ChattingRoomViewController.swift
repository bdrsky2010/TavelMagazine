//
//  ChttingRoomViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

class ChattingRoomViewController: UIViewController {

    @IBOutlet weak var messageTextViewBackgroundView: UIView!
    
    @IBOutlet weak var messageTextView: UITextView! {
        
        didSet {
            
            messageTextView.delegate = self
        }
    }
    
    @IBOutlet weak var chatTableView: UITableView! {
        
        didSet {
        
            chatTableView.delegate = self
            chatTableView.dataSource = self
        }
    }
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    private let placeholder = "message"
    
    public var chatRoom: ChatRoom? {
        
        didSet {
            if let chatRoom, let chatTableView {
                chatTableView.reloadData()
                chatTableView.scrollToRow(at: IndexPath(row: chatRoom.chatList.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        
        configureUI()
        configureKeyboardNotification()
        configureTableView()
        configureMessageTextView()
    }
}

extension ChattingRoomViewController {
    
    private func configureUI() {
        configureTextViewBackgroundView()
        configureSendButton()
    }
    
    private func configureTextViewBackgroundView() {
        messageTextViewBackgroundView.layer.borderWidth = 1
        messageTextViewBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        messageTextViewBackgroundView.layer.cornerRadius = messageTextViewBackgroundView.frame.height / 2
    }
    
    private func configureSendButton() {
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = .systemBlue
        sendButton.setPreferredSymbolConfiguration(.init(pointSize: 28), forImageIn: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func sendButtonClicked() {
        
        guard let text = messageTextView.text else { return }
        
        if !text.isEmpty, text != placeholder {
            
            chatRoom?.chatList.append(Chat(user: .user, date: Date().nowDateConvertStr, message: text))
            
            messageTextView.text = nil
        }
    }
}

extension ChattingRoomViewController {
    
    private func configureKeyboardNotification() {
        
        // NotificationCenter를 통해 키보드 이벤트 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardHeight
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
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

extension ChattingRoomViewController: UITextViewDelegate {
    
    private func configureMessageTextView() {
        
        messageTextView.text = placeholder
        messageTextView.textColor = .systemGray
    }
    
    // 편집 시작, 커서 깜빡임
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == placeholder,
           textView.textColor == UIColor.systemGray {
            
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    // 편집 끝, 커서 안깜빡임
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = placeholder
            textView.textColor = .systemGray
        }
    }
}

extension ChattingRoomViewController: UITableViewDelegate { }

extension ChattingRoomViewController: UITableViewDataSource {
    
    private func configureTableView() {
        
        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.keyboardDismissMode = .onDrag
        
        let identifier = ReceptionMessageTableViewCell.identifier
        
        let nib = UINib(nibName: identifier, bundle: nil)
        chatTableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatRoom?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let identifier = ReceptionMessageTableViewCell.identifier
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ReceptionMessageTableViewCell
        
        let chat = chatRoom?.chatList[index]
        cell.chat = chat
        
        cell.configureCellContents(chat)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        let index = indexPath.row
//        
//        if let chatRoom, index == chatRoom.chatList.count - 2 {
//            print(index)
//            tableView.scrollToRow(at: IndexPath(row: index + 1, section: 0), at: .bottom, animated: true)
//        }
    }
}
