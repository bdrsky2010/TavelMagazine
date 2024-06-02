//
//  CityDetailInfoTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit
import Kingfisher

class CityDetailInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var ratingAndSaveLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet var ratingImageViewList: [UIImageView]!
    
    // 인스턴스를 생성할 때 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
    
    // root view의 sub view를 그릴 때 호출
    // 동적으로 sub view의 UI를 변경해줘야 할 때
    // 여기서 작성
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // cell이 재사용되기 전에 호출
    // 재사용되기 전에 UI 수정할 일 있으면
    // 여기에 작성
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
        
        ratingAndSaveLabel.text = travel.gradeAndSave ?? ""
        
        ratingImageViewList.enumerated().forEach {
            let index = $0.offset
            let imageView = $0.element
            
            imageView.image = UIImage(systemName: "star.fill")
            imageView.tintColor = index < travel.roundGradeToInt ? .systemYellow : .systemGray3
        }
        
        if let url = travel.travel_image?.stringToURL {
            thumbnailImageView.configureImageWithKF(url: url)
        }
        
        changeLikeImage(likeImageView, isLike: travel.like ?? false)
    }
    
    public func changeLikeImage(_ imageView: UIImageView, isLike: Bool) {
        let likeImageName = isLike ? "heart.fill" : "heart"
        let imageTintColor: UIColor = isLike ? .systemRed : .white
        
        imageView.image = UIImage(systemName: likeImageName)
        imageView.tintColor = imageTintColor
        
    }
}
