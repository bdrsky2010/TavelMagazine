//
//  PopularCityViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

class PopularCityViewController: UIViewController {

    @IBOutlet weak var popularCityTableView: UITableView!
    @IBOutlet weak var domesticSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let popularCityList = CityInfo.city
    
    private var filteredList: [City] = []
    private var segmentedIndex = 0
    private var containsClosure = { (name: String, englishName: String, explain: String, text: String) -> Bool in
        return name.contains(text) || englishName.contains(text) || explain.contains(text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "인기 도시 "
        filteredList = popularCityList
        configureSegmentedControlAction()
        configureTableView()
    }
}

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        defer {
            popularCityTableView.reloadData()
        }
        
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            filteredList = popularCityList
            return
        }
        
        searchBar.text = text
        
        filterCityList()
        
        filteredList = filteredList.filter { containsClosure($0.city_name.lowercased(),
                                                             $0.city_english_name.lowercased(),
                                                             $0.city_explain.lowercased(),
                                                             text.lowercased()) }
    }
}

// MARK: Configure SegmentedControl
extension PopularCityViewController {
    private func configureSegmentedControlAction() {
        domesticSegmentedControl.addTarget(self, action: #selector(changedSegmentedIndex), for: .valueChanged)
    }
    
    private func filterCityList() {
        
        if segmentedIndex == 0 {
            filteredList = popularCityList
        } else if segmentedIndex == 1 {
            filteredList = popularCityList.filter { $0.domestic_travel }
        } else {
            filteredList = popularCityList.filter { !$0.domestic_travel }
        }
    }
    
    @objc
    private func changedSegmentedIndex(sender: UISegmentedControl) {
        segmentedIndex = sender.selectedSegmentIndex
        
        filterCityList()
        defer {
            popularCityTableView.reloadData()
            view.endEditing(true)
        }
        
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            return
        }
        
        searchBar.text = text
        
        filteredList = filteredList.filter { containsClosure($0.city_name.lowercased(),
                                                             $0.city_english_name.lowercased(),
                                                             $0.city_explain.lowercased(),
                                                             text.lowercased()) }
    }
}

// MARK: Configure TableView
extension PopularCityViewController {
    private func configureTableView() {
        let nib = UINib(nibName: PopularCityTableViewCell.reuseIdentifier, bundle: nil)
        
        popularCityTableView.register(nib, forCellReuseIdentifier: PopularCityTableViewCell.reuseIdentifier)
        
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        
        popularCityTableView.rowHeight = 160
        popularCityTableView.separatorStyle = .none
        popularCityTableView.keyboardDismissMode = .onDrag
    }
}

// MARK: Configure UITableViewDelegate
extension PopularCityViewController: UITableViewDelegate {
    
}

// MARK: Configure UITableViewDataSource
extension PopularCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let city = filteredList[index]
        
        let identifier = PopularCityTableViewCell.reuseIdentifier
        
        let cell = popularCityTableView.dequeueReusableCell(withIdentifier: identifier,
                                                            for: indexPath) as! PopularCityTableViewCell
        cell.configureCellContent(city)
        
        cell.changeTextColor(city, text: searchBar.text)
        
        return cell
    }
}
