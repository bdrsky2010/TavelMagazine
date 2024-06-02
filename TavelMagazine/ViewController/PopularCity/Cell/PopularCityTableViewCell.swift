//
//  PopularCityTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit
import Kingfisher

class PopularCityTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PopularCityTableViewCell"
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityExplainBackgroundView: UIView!
    @IBOutlet weak var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// MARK: Coufigure UI
extension PopularCityTableViewCell {
    
    private func configureUI() {
        configureRootView()
        configureCellView()
        configureCityImageView()
        configurecityExplainBackgroundView()
        configureCityLabel()
    }
    
    private func configureRootView() {
        rootView.layer.cornerRadius = 20
        rootView.layer.maskedCorners = .ArrayLiteralElement(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        rootView.layer.shadowColor = UIColor.systemGray.cgColor
        rootView.layer.shadowOpacity = 1
        rootView.layer.shadowRadius = 4
        rootView.layer.shadowOffset = .init(width: 3, height: 3)
    }
    
    private func configureCellView() {
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 20
        cellView.layer.maskedCorners = .ArrayLiteralElement(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
    }
    
    private func configureCityImageView() {
        cityImageView.contentMode = .scaleAspectFill
    }
    
    private func configurecityExplainBackgroundView() {
        cityExplainBackgroundView.layer.backgroundColor = UIColor.label.cgColor
        cityExplainBackgroundView.layer.opacity = 0.7
    }
    
    private func configureCityLabel() {
        configureLabel(cityNameLabel, 
                       font: UIFont.systemFont(ofSize: 20,
                                               weight: .bold),
                       textColor: .systemBackground,
                       numberOfLines: 1)
        
        configureLabel(cityExplainLabel,
                       font: UIFont.systemFont(ofSize: 13,
                                               weight: .semibold),
                       textColor: .systemBackground,
                       numberOfLines: 1)
    }
    
    private func configureLabel(_ label: UILabel, font: UIFont, textColor: UIColor, numberOfLines: Int) {
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
    }
}

// MARK: Configure Cell Content
extension PopularCityTableViewCell {
    public func configureCellContent(_ city: City) {
        if let url = city.city_image.stringToURL {
            cityImageView.configureImageWithKF(url: url)
        } else {
            cityImageView.backgroundColor = .pastelBlue
        }
        
        cityNameLabel.text = city.cityName
        cityExplainLabel.text = city.city_explain
    }
    
    public func changeTextColor(_ city: City, text: String?) {
        guard let text, !text.isEmpty else { return }
        cityNameLabel.attributedText = cityNameLabel.text?.changedSearchTextColor(text)
        cityExplainLabel.attributedText = cityExplainLabel.text?.changedSearchTextColor(text)
    }
}
