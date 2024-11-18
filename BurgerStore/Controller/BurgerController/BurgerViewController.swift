//
//  BurgerViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/01/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

@available(iOS 16.0, *)
class BurgerViewController: BaseListController ,UICollectionViewDelegateFlowLayout {
    
    private var product: [BurgerModel] = []
    let header = "Header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAllBurgers()
    }

    
    deinit {
        
    }
    //MARK: Net Work: fetch all
    private func fetchAllBurgers() {
        
        BurgerNetWork.shared.fetchData { results in
            switch results {
            case .success(let product):
                self.product = product
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: Setup UI
    private func setupUI() {
        collectionView.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.12, alpha: 1.00)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(BurgerPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header)
        tabBarController?.tabBar.barTintColor = UIColor(red: 0.22, green: 0.21, blue: 0.25, alpha: 1.00)
        
    }

}
//MARK: BurgerViewController Fire Base Controller

//MARK: EXTENSION Table View Controller
@available(iOS 16.0, *)
extension BurgerViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        product.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        .init(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    
    //MARK: Did Select a Product
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = product[indexPath.row]
        
        let burgerController1 = UIHostingController(rootView: BurgerDetailsView(product: product))
        
        burgerController1.modalTransitionStyle = .coverVertical
        burgerController1.modalPresentationStyle = .fullScreen
        present(burgerController1, animated: false)
        
        }

    // MARK: HEADER
    override func collectionView(_ collectionView: UICollectionView, 
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: header, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        .init(width: view.frame.width, height: 80)
    }
    
    
    //MARK: CELL
    override func collectionView(_ collectionView: UICollectionView, 
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let product = product[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            MainBurgerCell(product: product)
        })
        
        return cell
    }


}
//MARK: DELEGATE
//MARK: create custom SwiftUI View Controller

@available(iOS 16.0, *)
struct HomeRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        BurgerViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    struct ProductCellPreview: PreviewProvider {
        static var previews: some View {
            HomeRepresentable()
        }
    }
}

