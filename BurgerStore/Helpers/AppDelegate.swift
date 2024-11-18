//
//  AppDelegate.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 09/12/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import UserNotifications
import SwiftUI
import CoreData

@main
@available(iOS 16.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let notifications = NotificationController()
    let vc = LoginSignInViewController()
    let burgerController = BurgerViewController()
    let shop = ShopCardView(viewModel: ShoppViewModel.shared)
    
    
    func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UIHostingController(rootView: vc)
//        window?.rootViewController = burgerController
        notifications.requestAuthorization()
        notifications.notificationCenter.delegate = self
        
        

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        notifications.notificationCenter.setBadgeCount(0) { error in
            if let error = error {
                print("applicationDidBecomeActive: ", error.localizedDescription)
            }
        }
    }
}
//MARK: userNotificationCenter получаем уведомления в приложение
@available(iOS 16.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: 
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .sound])
    }
//    обрабатываем полученное сообщение
    func userNotificationCenter(_ center: UNUserNotificationCenter, 
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == UUID().uuidString {
            print("Handling notification with the local identifire")
        }
        completionHandler()
    }
    
}
