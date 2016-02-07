//
//  AppDelegate.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 02/05/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var shortcutItem: UIApplicationShortcutItem?
	var window: UIWindow?
    var portrait: Bool = true

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var performShortcutDelegate = true
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            self.shortcutItem = shortcutItem
            performShortcutDelegate = false
        }
		return performShortcutDelegate
	}

	func applicationWillResignActive(application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(application: UIApplication) {
        // we first check if Touch ID protection is enabled
        if (User.instantiateUserStored()){
            if (UserPreferences.touchId) {
                User.authenticated = false
                //we protect the app as Touch ID is enabled
            }
        }
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        UserPreferences.touchID()
        FactorySync.offlineMode = false
        if User.instantiateUserStored() {
            FactorySync.getConfigManager().getLastVersion { (version) -> Void in
                if let versionDB: Int = version { //checking if sync is needed
                    FactorySync.getConfigManager().saveConfig({ (result) -> Void in
                        if result {
                            print("config saved")
                            //sync
                            FactoryHistory.getHistory().sync { (success) -> (Void) in
                                print("\(success) in AppDelegate")
                            }
                        } else {
                            print("error loading config, working with local config")
                        }
                    })
                    print("AppDelegate localVersion = \(FactorySync.getConfigManager().loadVersion()) dbVersion = \(versionDB)")
                    if FactorySync.getConfigManager().loadVersion() != versionDB { //prompting a sync
                        NSNotificationCenter.defaultCenter().postNotificationName("update", object: nil)
                    }
                }
            }
        }
	}

	func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        guard let shortcut = shortcutItem else { return }
        handleShortcut(shortcut)
        self.shortcutItem = nil
	}

	func applicationWillTerminate(application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
    
    
    //Quick Actions
    enum quickActions: String {
        case Training = "training"
        case Solo = "solo"
        case Leaderboard = "leaderboard"
        case Newsfeed = "newsfeed"
    }
    
    func handleShortcut( shortcutItem:UIApplicationShortcutItem ) -> Bool {
        var succeeded = false
        switch shortcutItem.type {
        case quickActions.Training.rawValue:
            NSNotificationCenter.defaultCenter().postNotificationName("goTraining", object: nil)
            succeeded = true
        case quickActions.Solo.rawValue:
            NSNotificationCenter.defaultCenter().postNotificationName("goSolo", object: nil)
            succeeded = true
        case quickActions.Leaderboard.rawValue:
            NSNotificationCenter.defaultCenter().postNotificationName("goLeaderboard", object: nil)
            succeeded = true
        case quickActions.Newsfeed.rawValue:
            NSNotificationCenter.defaultCenter().postNotificationName("goNewsfeed", object: nil)
            succeeded = true

        default:
            print("error")
        }
        return succeeded
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        //print("Application performActionForShortcutItem")
        completionHandler( handleShortcut(shortcutItem) )
    }
    
}

