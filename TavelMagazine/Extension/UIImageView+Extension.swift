//
//  UIImageView+Extension.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

extension UIImageView {
    public func configureImageWithKF(urlString: String) {
        let url = URL(string: urlString)
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            options: [.cacheOriginalImage]) { result in
            switch result {
            case .success(let value):
                print(value.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
