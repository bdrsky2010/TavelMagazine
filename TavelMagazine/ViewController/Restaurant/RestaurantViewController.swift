//
//  RestaurantViewController.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 5/30/24.
//

import UIKit
import MapKit

class RestaurantViewController: UIViewController {

    static let identifier = "RestaurantViewController"
    
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var textFieldCoverView: UIView!
    @IBOutlet weak var foodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    
    private let restaurantPicker = UIPickerView()
    
    private var restaurantDictionary: [String: Restaurant] {
        var dic: [String: Restaurant] = [:]
        RestaurantList.restaurantArray.forEach { dic[$0.name] = $0 }
        
        return dic
    }
    
    private var restaurantTitleList: [[String]] {
        var list: [[String]] = []
        
        let restaurantArray = RestaurantList.restaurantArray
        
        var totalTitleList = restaurantArray.map { $0.name }
        totalTitleList.insert("전체", at: 0)
        
        var koreanTitleList = restaurantArray.filter { $0.category == "한식" }.map { $0.name }
        koreanTitleList.insert("전체", at: 0)
        
        var chineseTitleList = restaurantArray.filter { $0.category == "중식" }.map { $0.name }
        chineseTitleList.insert("전체", at: 0)
        
        list.append(totalTitleList)
        list.append(koreanTitleList)
        list.append(chineseTitleList)
        
        return list
    }
    
    private var segmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "문래동 맛집 탐방"
        
        configureTextFieldCoverView()
        
        configureSegmentedControl()
        
        filterTextField.tintColor = .clear
        filterTextField.borderStyle = .none
        filterTextField.inputView = restaurantPicker
        filterTextField.placeholder = "Filter"
        
        configurePickerView()
        
        configureMapView()
    }
}

// MARK: Configure textFieldCoverView
extension RestaurantViewController {
    private func configureTextFieldCoverView() {
        
        textFieldCoverView.backgroundColor = .clear
        textFieldCoverView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(textFieldCoverTapAction))
        
        textFieldCoverView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func textFieldCoverTapAction() {
        filterTextField.becomeFirstResponder() // 텍스트 필드에 포커스 (편집 상태로 변경)
    }
}

// MARK: Configure UISegmentedControl
extension RestaurantViewController {
    
    private func configureSegmentedControl() {
        foodSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc
    private func segmentedControlValueChanged() {
        segmentIndex = foodSegmentedControl.selectedSegmentIndex
        
        if filterTextField.isEditing {
            restaurantPicker.reloadComponent(0)
        }
    }
}

// MARK: Configure UIPickerViewDelegate
extension RestaurantViewController: UIPickerViewDelegate {
    
    private func configurePickerView() {
        restaurantPicker.delegate = self
        restaurantPicker.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restaurantTitleList[segmentIndex][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mapView.removeAnnotations(mapView.annotations)
        
        let title = restaurantTitleList[segmentIndex][row]
        
        if row == 0 {
            if segmentIndex == 0 {
                filterTextField.text = title
            } else if segmentIndex == 1 {
                filterTextField.text = "한식 \(title)"
            } else {
                filterTextField.text = "분식 \(title)"
            }
            
            mapView.addAnnotations(configureAnnotations() {
                let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
                mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
            })
            
        } else {
            filterTextField.text = title
            
            if let restaurant = restaurantDictionary[title] {
                let annotation = configureAnnotation(restaurant: restaurant) {
                    let center = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
                    mapView.setCenter(center, animated: true)
                }
                
                mapView.addAnnotation(annotation)
            }
        }
    }
}

// MARK: Configure UIPickerViewDataSource
extension RestaurantViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restaurantTitleList[segmentIndex].count
    }
}

// MARK: Configure MKMapViewDelegate
extension RestaurantViewController: MKMapViewDelegate {
    private func configureMapView() {
        
        mapView.delegate = self
        
        let mapViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped))
        mapView.isUserInteractionEnabled = true
        mapView.addGestureRecognizer(mapViewTapGesture)
        
        mapView.addAnnotations(configureAnnotations() {
            let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
            mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        })
    }
    
    @objc
    private func mapViewTapped() {
        filterTextField.resignFirstResponder()
    }
    
    private func configureAnnotations(closure: () -> Void) -> [MKPointAnnotation] {
        let list = restaurantTitleList[segmentIndex]
        let annotations = list.map {
            
            let restaurant = restaurantDictionary[$0]
            
            let title = restaurant?.name ?? "새싹 영등포캠퍼스"
            let coordinate = CLLocationCoordinate2D(latitude: restaurant?.latitude ?? 37.517742,
                                                    longitude: restaurant?.longitude ?? 126.886463)
            
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.coordinate = coordinate
            
            return annotation
        }
        
        closure()
        
        return annotations
    }
    
    private func configureAnnotation(restaurant: Restaurant, closure: () -> Void) -> MKPointAnnotation {
        let title = restaurant.name
        let coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        
        closure()
        
        return annotation
    }
}
