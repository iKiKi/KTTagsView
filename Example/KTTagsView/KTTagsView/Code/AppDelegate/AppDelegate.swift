//
//  AppDelegate.swift
//  KTTagsView
//
//  Copyright © 2018 KTTagsView. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

  // MARK: Properties

  var window: UIWindow?

  // MARK: - Internal methods
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Window
    self.window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewController = StoryboardScene.Main.mainViewController.instantiate()
    self.window?.rootViewController = UINavigationController(rootViewController: mainViewController)
    self.window?.makeKeyAndVisible()

    return true
  }
}
