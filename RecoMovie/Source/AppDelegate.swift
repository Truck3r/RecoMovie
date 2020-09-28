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

    private var network: NetworkInterface?
    private var movieListDataSource: MovieListDataSource?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let network = RemoteNetwork()
        self.network = network
        let movieListDataSource = MovieListNetworkDataSource(networkInterface: network)
        self.movieListDataSource = movieListDataSource
        window.rootViewController = UINavigationController(rootViewController: MovieListController(dataSource: movieListDataSource, networkInterface: network))
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
