//
//  TravelCityViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/27/24.
//

import UIKit

class CityDetailInfoViewController: UIViewController,
                                    UITableViewDelegate,
                                    UITableViewDataSource {
    
    @IBOutlet weak var cityTableView: UITableView!
    
    private var cityInfoList = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "도시 상세 정보"
        
        configureTableView()
    }
    
    private func configureTableView() {
        cityTableView.separatorStyle = .none
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
        
        let cityNib = UINib(nibName: CityDetailInfoTableViewCell.reuseIdentifier, bundle: nil)
        let adNib = UINib(nibName: AdvertiseTableViewCell.reuseIdentifier, bundle: nil)
        
        cityTableView.register(cityNib, forCellReuseIdentifier: CityDetailInfoTableViewCell.reuseIdentifier)
        cityTableView.register(adNib, forCellReuseIdentifier: AdvertiseTableViewCell.reuseIdentifier)
        
//        cityTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityInfoList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cityInfoList[indexPath.row].ad ? 70 : 160
    }
    
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
