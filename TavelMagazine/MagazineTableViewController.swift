//
//  MagazineTableViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/26/24.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "떠나보자 TRAVEL"
        
        tableView.rowHeight = 450
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Magazine.magazineList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MagazineTableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MagazineTableViewCell
        
        let index = indexPath.row
        let magazine = Magazine.magazineList[index]
        
        let url = URL(string: magazine.photo_image)
        
        cell.infoImageView.kf.indicatorType = .activity
        cell.infoImageView.kf.setImage(
            with: url,
            options: [.cacheOriginalImage]) { result in
            switch result {
            case .success(let value):
                print(value.image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        cell.titleLabel.text = magazine.title
        cell.subtitleLabel.text = magazine.subtitle
        cell.dateLabel.text = magazine.date.convertStrDate
        
        return cell
    }
}
