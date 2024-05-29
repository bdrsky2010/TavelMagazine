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
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)
            
            return
        }
        
        identifier = TouristSpotViewController.identifier
        
        let vc = storyboard?.instantiateViewController(withIdentifier: identifier) as! TouristSpotViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Configure UITableViewDataSource
extension CityDetailInfoViewController: UITableViewDataSource {
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return cityInfoList[indexPath.row].ad ? 70 : 160
    //    }
    
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