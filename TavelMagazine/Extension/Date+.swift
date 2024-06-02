//
//  Date+.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/3/24.
//

import Foundation

extension Date {
    
    public var nowDateConvertStr: String {
        
        let nowDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        let convertNowStr = dateFormatter.string(from: nowDate)
        
        return convertNowStr
    }
}
