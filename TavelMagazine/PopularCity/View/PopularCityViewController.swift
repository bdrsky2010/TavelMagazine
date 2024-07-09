//
//  PopularCityViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/29/24.
//

import UIKit

final class PopularCityViewController: UIViewController {

    @IBOutlet weak var popularCityTableView: UITableView!
    @IBOutlet weak var domesticSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let popularCityViewModel = PopularCityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
        configureNavigation()
        configureTableView()
    }
    
    private func configureNavigation() {
        navigationItem.title = "인기 도시 "
    }
    
    private func bindData() {
        popularCityViewModel.outputFilteredList.bind { [weak self] _ in
            guard let self else { return }
            popularCityTableView.reloadData()
        }
    }
}

extension PopularCityViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.text = searchBar.text?.trimmingCharacters(in: .whitespaces)
        popularCityViewModel.inputSearchQuery.value = searchBar.text
    }
}

// MARK: Configure SegmentedControl
extension PopularCityViewController {
    private func configureSegmentedControlAction() {
        domesticSegmentedControl.addTarget(self, action: #selector(changedSegmentedIndex), for: .valueChanged)
    }
    
    @objc
    private func changedSegmentedIndex(sender: UISegmentedControl) {
        popularCityViewModel.inputSegmentedIndexWithQuery.value = (sender.selectedSegmentIndex, searchBar.text)
        searchBar.resignFirstResponder()
    }
}

// MARK: Configure TableView
extension PopularCityViewController {
    private func configureTableView() {
        let nib = UINib(nibName: PopularCityTableViewCell.identifier, bundle: nil)
        
        popularCityTableView.register(nib, forCellReuseIdentifier: PopularCityTableViewCell.identifier)
        
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
        return popularCityViewModel.outputFilteredList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = popularCityTableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.identifier, for: indexPath) as? PopularCityTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.row
        let city = popularCityViewModel.outputFilteredList.value[index]
        cell.configureCellContent(city)
        cell.changeTextColor(city, text: searchBar.text)
        return cell
    }
}
