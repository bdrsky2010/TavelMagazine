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
}

extension String {
    
    func changedSearchTextColor(_ text: String?) -> NSAttributedString {
        guard let text, !text.isEmpty else {
            return NSAttributedString(string: self)
        }
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (self as NSString).range(of: text, options: .caseInsensitive))
        
        return attributedString
    }
}

extension String {
    
    var convertStrDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        
        guard let convertDate = dateFormatter.date(from: self) else { return nil }
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yy년 MM월 dd일"
        newDateFormatter.locale = Locale(identifier: "ko_KR")
        
        let convertStrDate = newDateFormatter.string(from: convertDate)
        return convertStrDate
    }
    // 2024-06-12 22:32
    var extractDate: String? { // 전체 날짜에서 날짜 데이터만 추출 후 다시 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let convertDate = dateFormatter.date(from: self) else { return nil }
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "yy.MM.dd"
        newDateFormatter.locale = Locale(identifier: "ko_KR")
        
        let convertStrDate = newDateFormatter.string(from: convertDate)
        return convertStrDate
    }
    
    var extractTime: String? { // 전체 날짜에서 날짜 데이터만 추출 후 다시 문자열로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let convertDate = dateFormatter.date(from: self) else { return nil }
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "HH:mm a"
        newDateFormatter.locale = Locale(identifier: "ko_KR")
        
        let convertStrDate = newDateFormatter.string(from: convertDate)
        return convertStrDate
    }
}
