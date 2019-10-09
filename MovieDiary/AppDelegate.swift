//
//  AppDelegate.swift
//  MovieDiary
//
//  Created by Raul on 09/10/2019.
//  Copyright © 2019 Raul. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // TODO(Add router here)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)

//        let router = MainRouter()
//        let controller = router.entrypoint()
        let entryController = UINavigationController(rootViewController: ViewController())
        window.rootViewController = entryController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

