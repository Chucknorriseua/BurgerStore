//
//  BeerController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 06/02/2024.
//

import UIKit
import SwiftUI

@available(iOS 16.0, *)
class ChinaFoodController: BaseListController ,UICollectionViewDelegateFlowLayout  {
    
    private var product: [ChinafoodElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.12, alpha: 1.00)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        
        Task {
            await fetchAllProductCocktails()
        }
    }

    private func fetchAllProductCocktails() async {
        do {
            product = try await BurgerNetWork.shared.fetchAllChinaFood()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, 
                                 didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, 
                                 numberOfItemsInSection section: Int) -> Int {
        product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let products = product[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ChinaFoodCell(chinaProduct: products)
        })
        return cell
    }

}
