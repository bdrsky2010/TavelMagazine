//
//  MagazineViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

class MagazineViewController: UIViewController,
                              UITableViewDelegate,
                              UITableViewDataSource {

    @IBOutlet weak var magazineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "떠나보자 TRAVEL"
        
        magazineTableView.delegate = self
        magazineTableView.dataSource = self
        magazineTableView.rowHeight = 450
        magazineTableView.separatorStyle = .none
        
        let nib = UINib(nibName: MagazineTableViewCell.reuseIdentifier,
                        bundle: nil)
        magazineTableView.register(nib,
                                   forCellReuseIdentifier: MagazineTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Magazine.magazineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MagazineTableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MagazineTableViewCell
        
        let index = indexPath.row
        let magazine = Magazine.magazineList[index]
        
        cell.configCellContent(magazine)
        
        return cell
    }
}
