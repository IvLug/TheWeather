//
//  AppDelegate.swift
//  TheWeather
//
//  Created by Иван Луганцов on 23.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appRouter: AppRouterType!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        appRouter = AppRouter()
        appRouter.showRootScreen()
        return true
    }
}

