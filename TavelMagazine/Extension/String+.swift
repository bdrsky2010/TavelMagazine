//
//  String+.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

extension String {
    var stringToURL: URL? {
        return URL(string: self)
    }
    
    func changedSearchTextColor(_ text: String?) -> NSAttributedString {
        guard let text, !text.isEmpty else {
            return NSAttributedString(string: self)
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (self as NSString).range(of: text, options: .caseInsensitive))
        
        return attributedString
    }
}
