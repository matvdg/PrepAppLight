//
//  Notification.swift
//  PrepAppLight
//
//  Created by Mathieu Vandeginste on 13/02/2016.
//  Copyright © 2016 PrepApp. All rights reserved.
//

import Foundation


class Notification {
    
    class func registerForNotifications(){
        UIApplication.sharedApplication().registerForRemoteNotifications()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
    }
    
    class func unregisterForNotifications(){
        UIApplication.sharedApplication().unregisterForRemoteNotifications()
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    class func sendLocalReminder(){
        if UserPreferences.notifications {
            //cancel the previous scheduled reminders
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            //scheduling a new local alert
            let notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 60*60*24*3)
            let texts = ["3 jours sans exercices, \(User.currentUser!.firstName),il est temps de lancer Prep'App!","Déjà trois jours se sont écoulés depuis votre dernier entraînement Prep'App, \(User.currentUser!.firstName) !", "\(User.currentUser!.firstName), il est temps d'aller sur Prep'App !","Sans nouvelles de vous depuis trois jours, \(User.currentUser!.firstName) !"]
            notification.alertBody = texts.shuffle().first!
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
}