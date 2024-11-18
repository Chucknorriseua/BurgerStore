//
//  Order.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 01/02/2024.
//

import Foundation
import FirebaseFirestore

struct Order {
    
    var id: String = UUID().uuidString
    var userId: String
    var shopModel = [ShopModel]()
    var date: Date
    var status: String
    
    var cost: Int {
        var sum = 0
        for products in shopModel {
            sum += products.cost
        }
        return sum
    }
    
    var represent: [String:Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userId"] = userId
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        repres["cost"] = cost
        return repres
    }
}

