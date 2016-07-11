//
//  AppDelegate.swift
//  Test
//
//  Created by Vijay on 7/6/16.
//  Copyright © 2016 Vijay. All rights reserved.
//

import UIKit

// MARK: - Class -

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties -
    
    var window: UIWindow?

    // MARK: - AppDelegate -
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("CountryListViewController") as! CountryListViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}














