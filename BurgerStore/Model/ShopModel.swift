//
//  ShoppViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import Foundation


struct ShopModel: Decodable {
    var id: String
    var product: Element
    var count: Int
    
}
