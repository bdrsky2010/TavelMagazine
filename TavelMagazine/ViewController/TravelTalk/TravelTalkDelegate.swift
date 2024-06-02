//
//  TravelTalkDelegate.swift
//  TavelMagazine
//
//  Created by Minjae Kim on 6/3/24.
//

import Foundation

protocol TravelTalkDelegate {
    
    func sendMessage(_ row: Int, chatRoom: ChatRoom)
}
