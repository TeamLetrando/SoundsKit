//
//  AppDelegate.swift
//  Example
//
//  Created by PATRICIA S SIQUEIRA on 11/10/21.
//

import UIKit
import SoundsKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        
        //First Settings for launch
        let isFirstLaunch = (UserDefaults.standard.value(forKey: "FirstLaunch") as? Bool) ?? false
        UserDefaults.standard.set(true, forKey: "Launch")
        if !isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
            ///Set Sounds Settings
            SoundsKit.setKeyAudio(true)
            SoundsKit.file = "Curious_Kiddo"
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

