//
//  String+.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import Foundation

extension String {
    var stringToURL: URL? {
        return URL(string: self)
    }
}
