//
//  MagazineViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

final class MagazineViewController: UIViewController {

    @IBOutlet weak var magazineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "떠나보자 TRAVEL"
        
        configureTableView()
    }
}

// MARK: Configure TableView
extension MagazineViewController {
    
    private func configureTableView() {
        magazineTableView.delegate = self
        magazineTableView.dataSource = self
        magazineTableView.rowHeight = UITableView.automaticDimension
//        magazineTableView.rowHeight = 450
        magazineTableView.separatorStyle = .none
        
        let nib = UINib(nibName: MagazineTableViewCell.identifier, bundle: nil)
        magazineTableView.register(nib, forCellReuseIdentifier: MagazineTableViewCell.identifier)
    }
}

// MARK: Configure UITableViewDelegate
extension MagazineViewController: UITableViewDelegate {
    
}

// MARK: Configure UITableViewDataSource
extension MagazineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Magazine.magazineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MagazineTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MagazineTableViewCell
        
        let index = indexPath.row
        let magazine = Magazine.magazineList[index]
        
        cell.configureCellContent(magazine)
        
        return cell
    }
}
