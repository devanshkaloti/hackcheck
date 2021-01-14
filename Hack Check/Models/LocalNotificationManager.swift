//
//  ScheduleNotification.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-26.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager
{
    var notifications = [Notification]()

    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
        
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    func schedule(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
                completion(true)
                break
            default:
                completion(false)
                break // Do nothing
            }
        }
    }
    
    
    
    private func scheduleNotifications() {
        for notification in notifications
        {
            let content      = UNMutableNotificationContent()
            content.title    = "Hack check for leaks against our updated database"
            content.body     = "It's your weekly reminder to check for any new breaches that contain your email id"
            content.sound    = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 604800, repeats: true)


            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in

                guard error == nil else { return }

                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
    
    
}


struct Notification {
    var id:String
    var title:String
    var datetime:DateComponents
}


