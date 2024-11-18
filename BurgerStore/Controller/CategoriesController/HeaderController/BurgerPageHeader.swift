//
//  BurgerPageHeader.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 21/01/2024.
//

import UIKit

@available(iOS 16.0, *)
class BurgerPageHeader: UICollectionReusableView {
    
    let burgerHeaderController = HorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(burgerHeaderController.view)
        burgerHeaderController.view.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

