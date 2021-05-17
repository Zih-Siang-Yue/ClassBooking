//
//  AppDelegate.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        let manager = NetworkManager()
        self.window?.rootViewController = ClassBookingViewController(networkManager: manager)
        
        return true
    }

}

