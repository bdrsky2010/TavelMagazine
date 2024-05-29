//
//  PopularCityViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {

    @IBOutlet weak var popularCityTableView: UITableView!
    
    private let popularCityList = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "인기 도시 "
    }
}

extension PopularCityViewController: UITableViewDelegate {
    
}

extension PopularCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = PopularCityTableViewCell.reuseIdentifier
        
        let cell = popularCityTableView.dequeueReusableCell(withIdentifier: identifier,
                                                            for: indexPath) as! PopularCityTableViewCell
        return cell
    }
    
    
}
