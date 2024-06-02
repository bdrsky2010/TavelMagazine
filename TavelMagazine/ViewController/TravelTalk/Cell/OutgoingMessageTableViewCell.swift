//
//  OutgoingMessageTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

class OutgoingMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var sendTimeLabel: UILabel!
    
    public var chat: Chat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureProfileImageView()
    }
}

extension OutgoingMessageTableViewCell {
    
    private func configureUI() {
        configureNicknameLabel()
        configureMessageBackgroundView()
        configureMessageLabel()
        configureSendTimeLabel()
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
                       font: .systemFont(ofSize: 13, weight: .bold),
                       numberOfLines: 1)
    }
    
    private func configureMessageBackgroundView() {
        messageBackgroundView.backgroundColor = .systemBackground
        messageBackgroundView.layer.cornerRadius = 10
        messageBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        messageBackgroundView.layer.borderWidth = 1
    }
    
    private func configureMessageLabel() {
        configureLabel(messageLabel,
                       font: .systemFont(ofSize: 14, weight: .bold),
                       numberOfLines: 0)
    }
    
    private func configureSendTimeLabel() {
        configureLabel(sendTimeLabel,
                       font: .systemFont(ofSize: 13, weight: .bold),
                       textColor: .systemGray)
    }
    
    public func configureCellContents(_ chat: Chat?) {
        
        guard let chat else { return }
        
        profileImageView.image = UIImage(named: chat.user.profileImage)
        nicknameLabel.text = chat.user.rawValue
        messageLabel.text = chat.message
        sendTimeLabel.text = chat.date.extractTime
    }
    
    private func configureImageView(_ imageView: UIImageView, contentMode: UIView.ContentMode? = nil, tintColor: UIColor? = nil, cornerRadius: CGFloat? = nil, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        
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
    }
}
