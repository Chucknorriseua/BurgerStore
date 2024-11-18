//
//  ChinaShopModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 17/06/2024.
//

import Foundation

struct ChinaShopModel:  Identifiable, Codable, Hashable {
    let id: String
    var product: ChinafoodElement
    var count: Int {
        didSet {
            count = min(max(count, 1),10)
        }
    }
    var price: Int = 5
    
    var cost: Int {
        return price * count
    }
var represent: [String:Any] {
    var repres = [String:Any]()
    
    repres["id"] = id
    repres["count"] = count
    repres["product"] = product.title
    repres["price"] = price
    repres["cost"] = cost
    
    return repres
}


    enum CodingKeys: String, CodingKey {
        case id
        case product
        case count
        case price
    }
  
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(count, forKey: .count)
        try container.encode(price, forKey: .price)
    }
    
}
