//
//  ShoppViewModel.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 26/01/2024.
//

import SwiftUI
import Combine
//MARK: Модель для добавления нашего продукта
class ShoppViewModel: ObservableObject {
    
    static let shared = ShoppViewModel()
    
    init() {}
    
    @Published var shopViewModel: [ShopModel] = [] 

    @Published var chinaViewModel: [ChinaShopModel] = [] 

    var total: Int {
        let shopTotal = shopViewModel.reduce(0) {$0 + (Int($1.product.price ?? 0) * $1.count)}
        let chinaTotal = chinaViewModel.reduce(0) {$0 + ($1.price * $1.count)}
        return shopTotal + chinaTotal
    }
    
    func addProductCart(_ product: ShopModel) {
        if !shopViewModel.contains(where: {$0.product.id == product.product.id}) {
            self.shopViewModel.append(product)
        }
    }
    
    func removeProductItem(at product: ShopModel) {
        if let index = shopViewModel.firstIndex(where: {$0.product.id == product.product.id}) {
            shopViewModel.remove(at: index)
        }
        
    }
    
    
    func plusTotal(shopModel: ShopModel) {
        if let index = shopViewModel.firstIndex(where: { $0.id == shopModel.id }) {
            shopViewModel[index].count += 1
        }
    }
    
    func minusTotal(shopModel: ShopModel) {
        if let index = shopViewModel.firstIndex(where: { $0.id == shopModel.id }) {
            let newCount = max(shopViewModel[index].count - 1, 1)
            shopViewModel[index].count = newCount
        }
    }
    
    
    // MARK: CHINA FUNC
    func plusTotalChina(shopModel: ChinaShopModel) {
        if let index = chinaViewModel.firstIndex(where: { $0.id == shopModel.id }) {
            chinaViewModel[index].count += 1
        }
    }
    
    func minusTotalChina(shopModel: ChinaShopModel) {
        if let index = chinaViewModel.firstIndex(where: { $0.id == shopModel.id }) {
            let newCount = max(chinaViewModel[index].count - 1, 1)
            chinaViewModel[index].count = newCount
        }
        
    }
    
    func addChinaProduct(_ product: ChinaShopModel) {
        if !chinaViewModel.contains(where: {$0.product.id == product.product.id}) {
            //            total += product.cost
            self.chinaViewModel.append(product)
        }
    }
    
    func removeProductChinaItem(at product: ChinaShopModel) {
        if let index = chinaViewModel.firstIndex(where: {$0.product.id == product.product.id}) {
            //            total -= product.cost
            chinaViewModel.remove(at: index)
        }
        
    }
    
    func changeColorMinus(value: Int) -> Color {
        return  value == 1 ? .gray : .white
    }
    
    func changeColorPlus(value: Int) -> Color {
        return value == 10 ? .gray : .white
    }
}
