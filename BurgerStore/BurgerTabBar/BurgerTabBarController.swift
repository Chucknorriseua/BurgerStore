//
//  ViewController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 09/12/2023.
//

import UIKit
import SwiftUI
import FirebaseAuth

let appColor: UIColor = UIColor(red: 0.87, green: 0.83, blue: 0.78, alpha: 1.00)
let appColor1: UIColor = UIColor(red: 0.22, green: 0.21, blue: 0.25, alpha: 1.00)

@available(iOS 16.0, *)
class BurgerTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.22, green: 0.21, blue: 0.25, alpha: 1.00)
        setupViews()
        setupTabBar()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser == nil {
            let settingsController = UIHostingController(rootView: LoginSignInViewController())
            settingsController.modalTransitionStyle = .crossDissolve
            settingsController.modalPresentationStyle = .fullScreen
            present(settingsController, animated: false) {
                
            }
        }
    }
    
    private func setupViews() {
        
        let menuVC = BurgerViewController()
        let shoppingVC = UIHostingController(rootView: ShopCardView(viewModel: ShoppViewModel.shared))
        let profileVC = UIHostingController(rootView: ProfileUserViewController(viewModel: ProfileViewModel(profile: MwUser(id: "",
                                                                                                                        fullName: "",
                                                                                                                        phone: "",
                                                                                                                        adress: "", 
                                                                                                                        city: "",
                                                                                                                        numberHome: ""))))

        menuVC.setTabBarImage(imageName: "menucard.fill", title: "Menu".uppercased())
        shoppingVC.setTabBarImage(imageName: "cart.circle.fill", title: "Shopping cart".uppercased())
        profileVC.setTabBarImage(imageName: "person.circle.fill", title: "Profile".uppercased())
        
        let menuNV = UINavigationController(rootViewController: menuVC)
        let shoppingNV = UINavigationController(rootViewController: shoppingVC)
        let profileNV = UINavigationController(rootViewController: profileVC)
        
        menuNV.navigationBar.barTintColor = appColor1
     
        
        hideNavigationBarList(menuNV.navigationBar)
        
        let tabBarList = [menuNV, shoppingNV, profileNV]
        
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarList(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = true
        navigationBar.isHidden = true
        
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}


