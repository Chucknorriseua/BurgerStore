//
//  HorizontalController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 21/01/2024.
//

import UIKit
import SwiftUI
@available(iOS 16.0, *)

class HorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let categoriesStack = CategoriesStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.12, alpha: 1.00)
        setupUI()
        buttonCategoriesSelector()
    }
    
    func createSelectorViewController(vc: UIViewController,
                                      color: UIColor,
                                      modalPresent: UIModalPresentationStyle,
                                      modalTransions: UIModalTransitionStyle ) {

        let navigatioController = vc
        navigatioController.view.backgroundColor = color
        navigatioController.modalTransitionStyle = modalTransions
        navigatioController.modalPresentationStyle = modalPresent
        present(navigatioController, animated: true)
    }
    
    private func buttonCategoriesSelector() {
        categoriesStack.cocktailsButton.addTarget(self,
                                                  action: #selector(handleButtonCocktails), for: .touchUpInside)
        categoriesStack.pizzaButton.addTarget(self,
                                              action: #selector(handleButtonPizza), for: .touchUpInside)
        categoriesStack.desertButton.addTarget(self,
                                               action: #selector(handleButtonDeser), for: .touchUpInside)
        categoriesStack.saladsButton.addTarget(self,
                                               action: #selector(handleButtonSalad), for: .touchUpInside)
    }
    
    @objc private func handleButtonPizza() {
//        createSelectorViewController(vc: CockTailseController(), color: .blue, modalPresent: .pageSheet, modalTransions: .crossDissolve)

    }
    
    @objc private func handleButtonDeser() {
//        createSelectorViewController(vc: CockTailseController(), color: .red, modalPresent: .pageSheet, modalTransions: .crossDissolve)
    }
    
    @objc private func handleButtonSalad() {
//        createSelectorViewController(vc: CockTailseController(), color: .yellow, modalPresent: .pageSheet, modalTransions: .crossDissolve)
    }
    
    @objc func handleButtonCocktails() {
    self.createSelectorViewController(vc: ChinaFoodController(),
                                      color: .clear,
                                      modalPresent: .pageSheet,
                                      modalTransions: .crossDissolve)
        
        }

        private func setupUI() {
            
       
            let stackView = UIStackView(arrangedSubviews: [categoriesStack])
            stackView.axis = .horizontal
            
            
            view.addSubview(stackView)
            
            stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             leading: view.leadingAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             trailing: view.trailingAnchor)
            
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
            
            stackView.fillSuperview()
            
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}


@available(iOS 16.0, *)
struct HomesssRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        HorizontalController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    struct ProductCellPreview: PreviewProvider {
        static var previews: some View {
            HomesssRepresentable()
        }
    }
}
