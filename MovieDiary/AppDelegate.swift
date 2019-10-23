//
//  AppDelegate.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import IQKeyboardManager
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let dependencies = Dependencies()
        router = Router(window: window!, dependencies: dependencies)
        

        // Make Kingfisher and only cache to disk and never use the RAM memory to prevent crashes in extreme cases.
        ImageCache.default.maxMemoryCost = 1
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().enabledTouchResignedClasses.add(MovieListController.self)
        
        return true
    }
}

