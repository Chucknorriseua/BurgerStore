//
//  ChinaFoodModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 17/06/2024.
//

import Foundation

struct ChinafoodElement: Decodable, Hashable, Identifiable {
        let id, title: String
        let difficulty: String
        let image: String?
    }

enum Difficulty: String, Codable {
        case easy = "Easy"
        case medium = "Medium"
}

    typealias Chinafood = [ChinafoodElement]


