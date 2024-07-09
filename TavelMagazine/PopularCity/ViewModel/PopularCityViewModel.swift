//
//  PopularCityViewModel.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 7/9/24.
//

import Foundation

final class PopularCityViewModel {
    private let popularCityList = CityInfo.city
    
    private var containsClosure = { (name: String, englishName: String, explain: String, text: String) -> Bool in
        return name.contains(text) || englishName.contains(text) || explain.contains(text)
    }
    
    var inputSegmentedIndexWithQuery: Observable<(index: Int, query: String?)> = Observable((0, ""))
    var inputSearchQuery: Observable<String?> = Observable("")
    var inputDefaultCityListTrigger: Observable<Void?> = Observable(nil)
    
    private(set) var outputFilteredList: Observable<[City]> = Observable([])
    
    init() {
        inputSegmentedIndexWithQuery.bind { [weak self] _ in
            guard let self else { return }
            changedSegmentedIndex()
        }
        
        inputSearchQuery.bind { [weak self] _ in
            guard let self else { return }
            realtimeSearchCity()
        }
        
        inputDefaultCityListTrigger.bind { [weak self] _ in
            guard let self else { return }
            outputFilteredList.value = popularCityList
        }
    }
    
    private func filterCityList(text: String) {
        if inputSegmentedIndexWithQuery.value.index == 0 {
            outputFilteredList.value = popularCityList
        } else if inputSegmentedIndexWithQuery.value.index == 1 {
            outputFilteredList.value = popularCityList.filter { $0.domestic_travel }
        } else {
            outputFilteredList.value = popularCityList.filter { !$0.domestic_travel }
        }
        
        outputFilteredList.value = outputFilteredList.value.filter { containsClosure($0.city_name.lowercased(), $0.city_english_name.lowercased(), $0.city_explain.lowercased(), text.lowercased()) }
    }
    
    private func changedSegmentedIndex() {
        guard let text = inputSegmentedIndexWithQuery.value.query, !text.isEmpty else { return }
        filterCityList(text: text)
    }
    
    private func realtimeSearchCity() {
        guard let text = inputSearchQuery.value, !text.isEmpty else {
            outputFilteredList.value = popularCityList
            return
        }
        filterCityList(text: text)
    }
}
