//
//  AppDelegate.swift
//  Password
//
//  Created by Devansh Kaloti on 2020-07-21.
//  Copyright © 2020 Devansh Kaloti. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Flurry_iOS_SDK


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

     var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self

        FirebaseApp.configure()
        
        Flurry.startSession("RMJPX8K7Q8Z8HBBXCTSJ", with: FlurrySessionBuilder
        .init()
        .withCrashReporting(true)
        .withLogLevel(FlurryLogLevelAll))
        
        
        return true
    }

//    // MARK: UISceneSession Lifecycle
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    @available(iOS 13.0, *)
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        print("Received notification with ID = \(id)")
        
        // check for new breaches
        
        let setting = Setting(setting: "email")
        if setting.value != "" {

            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let emailSearchVC = storyboard.instantiateViewController(withIdentifier: "emailSearch") as! EmailSearchViewController
        
            emailSearchVC.emailField.text = setting.value
            emailSearchVC.result()
            
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = emailSearchVC
            self.window?.makeKeyAndVisible()

        }

        completionHandler()
    }

}

