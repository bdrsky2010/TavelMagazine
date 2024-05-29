//
//  PopularCityTableViewCell.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class PopularCityTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PopularCityTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityExplainBackgroundView: UIView!
    @IBOutlet weak var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
