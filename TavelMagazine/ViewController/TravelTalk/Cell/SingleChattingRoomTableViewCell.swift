//
//  ChttingRoomTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

class SingleChattingRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var lastChatContentsLabel: UILabel!
    @IBOutlet weak var lastChatDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureProfileImageView()
    }
}

// MARK: Configure UI
extension SingleChattingRoomTableViewCell {
    
    private func configureUI() {
        
        configureNicknameLabel()
        configureLastChatContents()
        configureLastChatDate()
    }
    
    private func configureProfileImageView() {
        
        configureImageView(profileImageView,
                           contentMode: .scaleAspectFill,
                           tintColor: .pastelBlue,
                           cornerRadius: profileImageView.frame.width / 2,
                           borderColor: UIColor.systemGray.cgColor,
                           borderWidth: 0.3)
    }
    
    private func configureNicknameLabel() {
        
        configureLabel(nicknameLabel,
                       font: .systemFont(ofSize: 14, weight: .bold))
    }
    
    private func configureLastChatContents() {
        
        configureLabel(lastChatContentsLabel,
                       font: .systemFont(ofSize: 14, weight: .bold),
                       textColor: .systemGray)
    }
    
    private func configureLastChatDate() {
        
        configureLabel(lastChatDateLabel,
                       font: .systemFont(ofSize: 13, weight: .bold),
                       textColor: .systemGray2)
    }
    
    public func configureContents(_ chatRoom: ChatRoom?) {
        
        guard let chatRoom else { return }
        
        if let image = chatRoom.chatroomImage.first {
            profileImageView.image = UIImage(named: image)
        }

        nicknameLabel.text = chatRoom.chatroomName
        
        if let chat = chatRoom.chatList.last {
            lastChatDateLabel.text = chat.date.extractDate
            lastChatContentsLabel.text = chat.message
        }
    }
    
    private func configureImageView(_ imageView: UIImageView, contentMode: UIView.ContentMode? = nil, tintColor: UIColor? = nil, cornerRadius: CGFloat? = nil, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        
//        if let url { imageView.configureImageWithKF(url: url) }
//        if let systemName { imageView.image = UIImage(systemName: systemName) }
//        if let named { imageView.image = UIImage(named: named) }
        if let contentMode { imageView.contentMode = contentMode }
        if let tintColor { imageView.tintColor = tintColor }
        if let cornerRadius { imageView.layer.cornerRadius = cornerRadius }
        if let borderColor { imageView.layer.borderColor = borderColor }
        if let borderWidth { imageView.layer.borderWidth = borderWidth }
    }
    
    private func configureLabel(_ label: UILabel, font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil) {
        
        if let font { label.font = font }
        if let textColor { label.textColor = textColor }
        if let textAlignment { label.textAlignment = textAlignment }
        if let numberOfLines { label.numberOfLines = numberOfLines }
//        label.text = text
    }
}
