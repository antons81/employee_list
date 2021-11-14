//
//  AppDelegate.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let main = UINavigationController(rootViewController: EmployeeListConfigurator().makeViewController())
        main.navigationBar.setValue(true, forKey: "hidesShadow")
        window?.rootViewController = main
        window?.makeKeyAndVisible()

        
        return true
    }
}

