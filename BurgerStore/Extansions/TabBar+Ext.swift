//
//  TabBar+Ext.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 14/01/2024.
//
import UIKit

//MARK: СОЗДАНИЕ СТАТУС БАРА И НАСТРОЙКА ЕГО- СОЗДАНИЕ ФУНКЦИИ ДЛЯ IMAGE AND TITLE
extension UIViewController {
    
    func setStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line also
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    func setTabBarImage(imageName: String, title: String) {
        let configure = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configure)
//        let images = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
}
