//
//  DataBaseService.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 30/01/2024.
//

import UIKit
import FirebaseFirestore

class DataBaseService: ObservableObject {

    static let shared = DataBaseService()
    
    private let db = Firestore.firestore()
    
    private var userRf: CollectionReference {
        return db.collection("Users")
    }
    private var orderBur: CollectionReference {
        return db.collection("Orders_Burgers")
    }
    private var orderChi: CollectionReference {
        return db.collection("Orders_China")
    }
    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>)-> ()) {
        orderBur.document(order.id).setData(order.represent) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                self.setShopCarts(to: order.id, shopCarts: order.shopModel) { result in
                    switch result {
                        
                    case .success(let shopCart):
                        print(shopCart.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setOrdeChina(order: OrderChina, completion: @escaping (Result<OrderChina, Error>)-> ()) {
        orderChi.document(order.id).setData(order.represent) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                self.setShopCartsChina(to: order.id, shopCarts: order.chinaShop) { result in
                    switch result {
                        
                    case .success(let shopCart):
                        print(shopCart.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setShopCartsChina(to orderID: String, shopCarts: [ChinaShopModel],
                      completion: @escaping (Result<[ChinaShopModel], Error>)-> ()) {
        
        let shopRef = orderChi.document(orderID).collection("positions")
        for shopCart in shopCarts {
            shopRef.document(shopCart.id).setData(shopCart.represent)
        }
        completion(.success(shopCarts))
        
    }
    
    func setShopCarts(to orderID: String, shopCarts: [ShopModel],
                      completion: @escaping (Result<[ShopModel], Error>)-> ()) {
        
        let shopRef = orderBur.document(orderID).collection("positions")
        for shopCart in shopCarts {
            shopRef.document(shopCart.id).setData(shopCart.represent)
        }
        completion(.success(shopCarts))
        
    }
    
    
// MARK: Создания пользователя данных
    func setUser(user: MwUser, completion: @escaping (Result<MwUser, Error>) -> ()) {
        userRf.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<MwUser, Error>) -> ()) {
        
        userRf.document(AuthService.shared.currentUser!.uid).getDocument { snapShot, error in
            
            guard let snap = snapShot else { return }
            guard let data = snap.data() else { return }
            guard let fullName = data["fullName"] as? String else { return }
            guard let city = data["city"] as? String else { return }
            guard let adress = data["adress"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? String else { return }
            guard let numberHome = data["numberHome"] as? String else { return }
            
            let user = MwUser(id: id, fullName: fullName, phone: phone, adress: adress, city: city, numberHome: numberHome)
            
            completion(.success(user))
        }
    }
}
