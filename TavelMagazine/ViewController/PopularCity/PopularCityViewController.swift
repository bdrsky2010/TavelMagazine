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
        configureTableView()
    }
}

// MARK: Configure TableView
extension PopularCityViewController {
    private func configureTableView() {
        let nib = UINib(nibName: PopularCityTableViewCell.reuseIdentifier, bundle: nil)
        
        popularCityTableView.register(nib, forCellReuseIdentifier: PopularCityTableViewCell.reuseIdentifier)
        
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        
        popularCityTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: Configure UITableViewDelegate
extension PopularCityViewController: UITableViewDelegate {
    
}

// MARK: Configure UITableViewDataSource
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
