//
//  AdvertiseTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

class AdvertiseTableViewCell: UITableViewCell {

    static let reuseIdentifier = "AdvertiseTableViewCell"
    
    @IBOutlet weak var adCellView: UIView!
    @IBOutlet weak var adTitleView: UIView!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        configureUI()
        configureCellContent()
    }
    
    private func configureUI() {
        let randomUIColor = [UIColor.pastelRed, UIColor.pastelGreen, UIColor.pastelBlue].randomElement()!
        adCellView.backgroundColor = randomUIColor
        adCellView.layer.cornerRadius = 10
        
        adTitleView.layer.cornerRadius = 10
        adTitleView.backgroundColor = .white
        
        adTitleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        adTitleLabel.textColor = .black
        adTitleLabel.textAlignment = .center
        
        adDescriptionLabel.font = .systemFont(ofSize: 15, weight: .heavy)
        adDescriptionLabel.textColor = .black
        adDescriptionLabel.textAlignment = .center
        adDescriptionLabel.numberOfLines = 3
    }
    
    private func configureCellContent() {
        adTitleLabel.text = "AD"
    }
    
    public func changeDescriptionLabel(_ label: UILabel, text: String) {
        label.text = text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
