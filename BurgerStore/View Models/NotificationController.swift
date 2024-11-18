//
//  NotificationController.swift
//  BurgerStore
//
//  Created by Евгений Полтавец on 03/02/2024.
//

import UIKit


@available(iOS 16.0, *)
class NotificationController: NotificationCenter {
    
    static var sharet = NotificationController()
    let notificationCenter = UNUserNotificationCenter.current()
    

    func notify(title: String, subTitle: String)  {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        guard let path = Bundle.main.path(forResource: "burgerLabel", ofType: "png") else { return }
        
        let url = URL(filePath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "burgerLabel", url: url)
            content.attachments = [attachment]
        } catch {
            print("Error load image from bundle: ", error.localizedDescription)
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    self.getNotificationsSetting()
                }
                
            } else {
                print("Permission for push notifications denied.")
            }
        }
    }
    
    func getNotificationsSetting() {
        notificationCenter.getNotificationSettings { settings in
            print("Notifications settings: \(settings)")
        }
    }
    
}
