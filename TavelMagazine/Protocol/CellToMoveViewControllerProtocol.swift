//
//  CellToPushViewControllerProtocol.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

protocol CellToMoveViewControllerProtocol {
    func configureTitleLabelFontBlack45(_ label: UILabel)
    func configureTitleLabelText(_ label: UILabel, text: String)
    func configureNavigation()
}

extension CellToMoveViewControllerProtocol {
    func configureTitleLabelFontBlack45(_ label: UILabel) {
        label.font = .systemFont(ofSize: 45, weight: .black)
        label.textAlignment = .center
    }
    
    func configureTitleLabelText(_ label: UILabel, text: String) {
        label.text = text
    }
}
