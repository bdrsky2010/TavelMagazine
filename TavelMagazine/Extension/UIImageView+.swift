//
//  UIImageView+.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

extension UIImageView {
    public func configureImageWithKF(url: URL) {
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
    
    public func configureImageView(_ imageView: UIImageView, url: URL? = nil, systemName: String? = nil, contentMode: UIView.ContentMode? = nil, tintColor: UIColor? = nil, cornerRadius: CGFloat? = nil, borderColor: CGColor? = nil, borderWidth: CGFloat? = nil) {
        
        if let url { imageView.configureImageWithKF(url: url) }
        if let systemName { imageView.image = UIImage(systemName: systemName) }
        if let contentMode { imageView.contentMode = contentMode }
        if let tintColor { imageView.tintColor = tintColor }
        if let cornerRadius { imageView.layer.cornerRadius = cornerRadius }
        if let borderColor { imageView.layer.borderColor = borderColor }
        if let borderWidth { imageView.layer.borderWidth = borderWidth }
    }
}
