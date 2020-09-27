//
//  AppDelegate.swift
//  RecoMovie
//
//  Created by Sune Riedel on 15/09/2020.
//  Copyright © 2020 Sune Riedel. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MovieListController()
        self.window = window
        return true
    }
}
