//
//  AppDelegate.swift
//  YandexSchoolTestTask
//
//  Created by Бадый Шагаалан on 11.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [MainViewController()]
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController

        let statusBarFrame = UIApplication.shared.statusBarFrame
        let statusBarBackgroundView = UIView(frame: statusBarFrame)
        window?.addSubview(statusBarBackgroundView)
        statusBarBackgroundView.backgroundColor = ColorManager.currentStyle().mainColor
        
        navigationController.navigationBar.barTintColor = ColorManager.currentStyle().navBarTintColor
        #warning("fix status bar color")
        UIApplication.shared.statusBarStyle = {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .default
            }
        }()
        return true
    }
}

