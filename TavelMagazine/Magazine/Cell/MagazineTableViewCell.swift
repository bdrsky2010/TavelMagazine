//
//  MagazineTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/26/24.
//

import UIKit
import Kingfisher

final class MagazineTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        configureUI()
    }
    
    private func configureUI() {
        infoImageView.layer.cornerRadius = 10
        infoImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        
        subtitleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 0
        
        dateLabel.font = .systemFont(ofSize: 14, weight: .bold)
        dateLabel.textColor = .systemGray
    }
    
    public func configureCellContent(_ magazine: Magazine) {
        if let url = magazine.photo_image.stringToURL {
            infoImageView.configureImageWithKF(url: url)
        }
        
        titleLabel.text = magazine.title
        subtitleLabel.text = magazine.subtitle
        dateLabel.text = magazine.date.convertStrDate
    }
}
