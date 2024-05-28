//
//  MagazineTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/26/24.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {

    static let reuseIdentifier =  "MagazineTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        configUI()
    }
    
    private func configUI() {
        infoImageView.layer.cornerRadius = 10
        infoImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        subtitleLabel.textColor = .systemGray
        
        dateLabel.font = .systemFont(ofSize: 14, weight: .bold)
        dateLabel.textColor = .systemGray
    }
    
    public func configCellContent(_ magazine: Magazine) {
        if let url = magazine.imageURL {
            infoImageView.configureImageWithKF(url: url)
        }
        
        titleLabel.text = magazine.title
        subtitleLabel.text = magazine.subtitle
        dateLabel.text = magazine.date.convertStrDate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
