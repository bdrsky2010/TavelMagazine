//
//  AdvertiseViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class AdvertiseViewController: UIViewController {

    static let identifier = "AdvertiseViewController"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureUI()
    }
}

// MARK: configure CellToPushViewControllerProtocol
// Configure UI
extension AdvertiseViewController: CellToMoveViewControllerProtocol {
    private func configureUI() {
        configureTitleLabelFontBlack45(titleLabel)
        configureTitleLabelText(titleLabel, text: "광고 화면")
    }
    
    func configureNavigation() {
        navigationItem.title = "광고 화면"
        navigationController?.navigationBar.tintColor = .label
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(leftBarButtonAction))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    private func leftBarButtonAction() {
        dismiss(animated: true)
    }
}
