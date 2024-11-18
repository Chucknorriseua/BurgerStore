//
//  BurgerModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/01/2024.
//

import UIKit

// MARK: - Element
struct BurgerModel: Decodable, Hashable, Identifiable {
    let id: Int?
    let name: String?
    let images: [Images]?
    let desc: String?
    let ingredients: [Ingredient]?
    let price: Double?
    let veg: Bool
    
}

// MARK: - Image
struct Images: Decodable, Hashable {
    let sm, lg: String?
}

// MARK: - Ingredient
struct Ingredient: Codable, Hashable {
    let id: Int?
    let name: String?
    let img: URL?
}

