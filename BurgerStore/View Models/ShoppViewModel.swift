//
//  ShoppViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import SwiftUI

//MARK: Модель для добавления нашего продукта

class ShoppViewModel: ObservableObject {
    
    static let shared = ShoppViewModel()
    
    private init() {}
    
    @Published var shopViewModel = [ShopModel]()
    
    var cost: Double {
        var sum = 0
        
        for pos in shopViewModel {
            sum += Int(pos.cost) 
        }
        return Double(sum)
    }
    
    func addShopProduct(_ product: ShopModel) {
        self.shopViewModel.append(product)
    }
}
