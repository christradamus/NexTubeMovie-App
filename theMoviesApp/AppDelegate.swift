//
//  AppDelegate.swift
//  theMoviesApp
//
//  Created by Valeria Muñoz toro on 25-07-22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.red
        
        let navigationFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 32)!
        let navigationFontAttributes = [NSAttributedString.Key.font : navigationFont
        ]
        let navigationFontDos = UIFont(name: "AvenirNextCondensed-DemiBold", size: 23)!
        let navigationFontAttributesDos = [NSAttributedString.Key.font : navigationFontDos
        ]
        
        
        UINavigationBar.appearance().titleTextAttributes = navigationFontAttributes
        
        UIBarButtonItem.appearance().setTitleTextAttributes(navigationFontAttributesDos, for: .normal
        )
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

