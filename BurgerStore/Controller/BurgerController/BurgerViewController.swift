//
//  BurgerViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/01/2024.
//

import UIKit
import SwiftUI
@available(iOS 16.0, *)
class BurgerViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    private var product: [Element] = []
    private var ingrys: Ingredient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAllBurgers()
//        setupGradienLayer()
    }
    
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
    
    private func setupUI() {
        collectionView.backgroundColor = UIColor(patternImage: UIImage(named: "1111") ?? UIImage())
//        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 0.04)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        tabBarController?.tabBar.barTintColor = .black
        
    }
    
    private func setupGradienLayer() {
        
        let gradient = CAGradientLayer()
        let color1 = UIColor(named: "Yellow")
        let color22 = UIColor(named: "Blue")
        gradient.colors = [color22?.cgColor ?? "", color1?.cgColor ?? ""]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = view.frame
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    deinit {
        print("BurgerViewController->>>>>>>> de inito la camedia")
    }
    
}


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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = product[indexPath.row]
        let burgerController = UIHostingController(rootView: BurgerDetailsView(productss: product, ingrys: ingrys))
        navigationController?.pushViewController(burgerController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let product = product[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            BurgersCell(product: product)
        })
        return cell
    }
}

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
