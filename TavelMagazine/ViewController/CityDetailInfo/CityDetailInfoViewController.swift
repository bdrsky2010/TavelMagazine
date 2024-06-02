//
//  TravelCityViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

class CityDetailInfoViewController: UIViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    private var cityInfoList = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        
        configureTableView()
    }
}

// MARK: Configure TravelDelegate
extension CityDetailInfoViewController: TravelDelegate {
    
    func setCityCellLike(_ row: Int) {
        
        cityInfoList[row].like?.toggle()
        cityTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
}

// MARK: Configure TableView
extension CityDetailInfoViewController {
    
    private func configureTableView() {
        cityTableView.separatorStyle = .none
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityNib = UINib(nibName: CityDetailInfoTableViewCell.reuseIdentifier, bundle: nil)
        let adNib = UINib(nibName: AdvertiseTableViewCell.reuseIdentifier, bundle: nil)
        
        cityTableView.register(cityNib, forCellReuseIdentifier: CityDetailInfoTableViewCell.reuseIdentifier)
        cityTableView.register(adNib, forCellReuseIdentifier: AdvertiseTableViewCell.reuseIdentifier)
        
        cityTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityInfoList.count
    }
}

// MARK: Configure UITableViewDelegate
extension CityDetailInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var identifier: String
        
        let index = indexPath.row
        let cityInfo = cityInfoList[index]
        
        defer {
            cityTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        if cityInfo.ad {
            
            identifier = AdvertiseViewController.identifier
            
            let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as! AdvertiseViewController
            
            let cell = tableView.cellForRow(at: indexPath) as! AdvertiseTableViewCell
            
            vc.backgroundColor = cell.adCellView.backgroundColor
            vc.adContents = cityInfo.title
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)
            
            return
        }
        
        identifier = TouristSpotViewController.identifier
        
        let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as! TouristSpotViewController
        let stringURL = "https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fprod-files-secure.s3.us-west-2.amazonaws.com%2F543cf73d-3746-44e3-b9b5-ff66847a8600%2F5876bf0b-6f27-42e5-bfe5-65cf8848c547%2F(%25EC%25B6%2595%25EC%2595%25BD)%25EC%2583%2588%25EC%258B%25B9SeSAC_CI.png&blockId=ad17acdf-4df8-4e4a-85d2-a99b0643cdf4&width=256"
        
        vc.delegate = self
        vc.row = index
        
        vc.travel = cityInfo
        vc.profileImageURL = stringURL.stringToURL
        vc.profileName = "SeSAC"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Configure UITableViewDataSource
extension CityDetailInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cityInfo = cityInfoList[index]
        
        var identifier: String
        
        if cityInfo.ad { // 광고 속성이 True인 경우
            
            identifier = AdvertiseTableViewCell.reuseIdentifier
            
            let cell = cityTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AdvertiseTableViewCell
            
            cell.changeDescriptionLabel(cell.adDescriptionLabel, text: cityInfo.title)
            
            return cell
        }
        
        // 광고 속성이 False인 경우
        identifier = CityDetailInfoTableViewCell.reuseIdentifier
        
        let cell = cityTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CityDetailInfoTableViewCell
        
        cell.configureCellContent(cityInfo)
        
        cell.likeImageView.tag = index
        cell.likeImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(likeImageTapped))
        cell.likeImageView.addGestureRecognizer(tapGesture)
        
        return cell
    }
    
    @objc
    private func likeImageTapped(sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        
        let index = imageView.tag
        
        guard let cell = cityTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? CityDetailInfoTableViewCell else { return }
        
        cityInfoList[index].like?.toggle()
        
        cell.changeLikeImage(imageView, isLike: cityInfoList[index].like ?? false)
    }
}
