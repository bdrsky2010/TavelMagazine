//
//  ReceptionMessageTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

class ReceptionMessageTableViewCell: UITableViewCell {

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
        
        
    }
}

extension ReceptionMessageTableViewCell {
    
    private func configureUI() {
        configureMessageBackgroundView()
        configureMessageLabel()
        configureSendTimeLabel()
    }
    
    private func configureMessageBackgroundView() {
        messageBackgroundView.backgroundColor = .systemGray4
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
        
        messageLabel.text = chat.message
        sendTimeLabel.text = chat.date.extractTime
    }
    
    private func configureLabel(_ label: UILabel, font: UIFont? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment? = nil, numberOfLines: Int? = nil) {
        
        if let font { label.font = font }
        if let textColor { label.textColor = textColor }
        if let textAlignment { label.textAlignment = textAlignment }
        if let numberOfLines { label.numberOfLines = numberOfLines }
    }
}
