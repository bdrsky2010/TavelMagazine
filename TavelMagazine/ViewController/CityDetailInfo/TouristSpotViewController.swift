//
//  TouristSpotViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class TouristSpotViewController: UIViewController {

    static let identifier = "TouristSpotViewController"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureUI()
    }
}

extension TouristSpotViewController: CellToMoveViewControllerProtocol {
    private func configureUI() {
        configureTitleLabelFontBlack45(titleLabel)
        configureTitleLabelText(titleLabel, text: "관광지 화면")
    }
    
    func configureNavigation() {
        navigationItem.title = "관광지 화면"
        navigationController?.navigationBar.tintColor = .label
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    private func leftBarButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
