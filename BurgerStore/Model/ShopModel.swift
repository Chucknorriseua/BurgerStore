//
//  ShoppViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import Foundation

struct ShopModel: Identifiable, Codable, Hashable {

        let id: String
        var product: BurgerModel
        var count: Int {
        didSet {
            count = min(max(count, 1),10)
        }
    }

        var cost: Int {
            return Int(product.price ?? 0.0) * count
        }
            
        var represent: [String:Any] {
            var repres = [String:Any]()
            
            repres["id"] = id
            repres["count"] = count
            repres["product"] = product.name
            repres["price"] = product.price
            repres["cost"] = cost
            
            return repres
        }
    
    
        enum CodingKeys: String, CodingKey {
            case id
            case product
            case count
        }
      
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(count, forKey: .count)
        }
        
        
    }
