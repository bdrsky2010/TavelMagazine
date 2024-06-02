//
//  TravelDelegate.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/2/24.
//

import UIKit

// MARK: CityDetailInfo ViewController Data Pass Protocol
@objc
protocol TravelDelegate {
    @objc optional func setCityCellLike(_ row: Int)
}
