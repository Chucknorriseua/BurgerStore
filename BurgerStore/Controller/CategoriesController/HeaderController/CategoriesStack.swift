//
//  CategoriesCell.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 06/02/2024.
//

import UIKit

@available(iOS 16.0, *)
class CategoriesStack: UIStackView {
    
    
    static func CreateButton(image: UIImageView) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.image?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 0.87, green: 0.83, blue: 0.78, alpha: 0.50)), for: .normal)
        button.contentMode = .scaleAspectFill
        
        return button
    }
    
    let pizzaButton = CreateButton(image: UIImageView(image: UIImage(named: "pizza1")))
    let saladsButton = CreateButton(image: UIImageView(image: UIImage(named: "salad1")))
    let cocktailsButton = CreateButton(image: UIImageView(image: UIImage(named: "china1")))
    let desertButton = CreateButton(image: UIImageView(image: UIImage(named: "cake")))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        
        let buttonArray =  [pizzaButton, saladsButton, cocktailsButton, desertButton]
        
        buttonArray.forEach { button in
        
        self.addArrangedSubview(button)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
