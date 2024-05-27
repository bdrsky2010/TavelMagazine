//
//  CityDetailInfoTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit
import Kingfisher

class CityDetailInfoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CityDetailInfoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingAndSaveLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet var ratingImageViewList: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configureUI()
    }
    
    private func configureUI() {
        configureLabel()
        configureImageView()
    }
    
    private func configureLabel() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .label
        
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 0
        
        ratingAndSaveLabel.font = .systemFont(ofSize: 12, weight: .bold)
        ratingAndSaveLabel.textColor = .systemGray2
    }
    
    private func configureImageView() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 10
    }
    
    public func configureCellContent(_ travel: Travel) {
        titleLabel.text = travel.title
        subtitleLabel.text = travel.description
        
        let grade = travel.grade ?? 0.0
        let save = travel.save ?? 0
        ratingAndSaveLabel.text = "(\(grade.formatted())) ∙ 저장 \(save.formatted())"
        
        ratingImageViewList.enumerated().forEach {
            let index = $0.offset
            let imageView = $0.element
            
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = index < Int(round(grade)) ? .systemYellow : .systemGray3
        }
        
        let urlString = travel.travel_image ?? ""
        thumbnailImageView.configureImageWithKF(urlString: urlString)
        
        changeLikeImage(likeImageView, isLike: travel.like ?? false)
    }
    
    public func changeLikeImage(_ imageView: UIImageView, isLike: Bool) {
        let likeImageName = isLike ? "heart.fill" : "heart"
        let imageTintColor: UIColor = isLike ? .systemRed : .white
        
        imageView.image = UIImage(systemName: likeImageName)
        imageView.tintColor = imageTintColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
