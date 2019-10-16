//
//  AppDelegate.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var router: Router?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        router = Router(window: window!, dependencies: Dependencies())
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().enabledTouchResignedClasses.add(MovieListController.self)
        
        return true
    }
}

