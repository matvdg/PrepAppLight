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
    
    class func sendLocalReminders(){
        
        if UserPreferences.notifications {
            let day: Double = 60*60*24
            let dates = ["trois jours", "une semaine", "quinze jours", "un mois"]
            //cancel the previous scheduled reminders
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            //scheduling local alerts
            let notification3 = UILocalNotification()
            notification3.fireDate = NSDate(timeIntervalSinceNow: 3*day)
            var texts = ["Déjà \(dates[0]) sans exercices, \(User.currentUser!.firstName), il est temps de lancer Prep'App!","Déjà \(dates[0]) depuis votre dernier entraînement Prep'App, \(User.currentUser!.firstName) !", "\(User.currentUser!.firstName), il est temps d'aller sur Prep'App !","Sans nouvelles de vous depuis \(dates[0]), \(User.currentUser!.firstName) !"]
            notification3.alertBody = texts.shuffle().first!
            notification3.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification3)
            let notification7 = UILocalNotification()
            notification7.fireDate = NSDate(timeIntervalSinceNow: 7*day)
            texts = ["Déjà \(dates[1]) sans exercices, \(User.currentUser!.firstName), il est temps de lancer Prep'App!","Déjà \(dates[1]) depuis votre dernier entraînement Prep'App, \(User.currentUser!.firstName) !", "\(User.currentUser!.firstName), il est temps d'aller sur Prep'App !","Sans nouvelles de vous depuis \(dates[1]), \(User.currentUser!.firstName) !"]
            notification7.alertBody = texts.shuffle().first!
            notification7.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification7)
            let notification15 = UILocalNotification()
            notification15.fireDate = NSDate(timeIntervalSinceNow: 15*day)
            texts = ["Déjà \(dates[2]) sans exercices, \(User.currentUser!.firstName), il est temps de lancer Prep'App!","Déjà \(dates[2]) depuis votre dernier entraînement Prep'App, \(User.currentUser!.firstName) !", "\(User.currentUser!.firstName), il est temps d'aller sur Prep'App !","Sans nouvelles de vous depuis \(dates[2]), \(User.currentUser!.firstName) !"]
            notification15.alertBody = texts.shuffle().first!
            notification15.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification15)
            let notification30 = UILocalNotification()
            notification30.fireDate = NSDate(timeIntervalSinceNow: 30*day)
            texts = ["Déjà \(dates[3]) sans exercices, \(User.currentUser!.firstName), il est temps de lancer Prep'App!","Déjà \(dates[3]) depuis votre dernier entraînement Prep'App, \(User.currentUser!.firstName) !", "\(User.currentUser!.firstName), il est temps d'aller sur Prep'App !","Sans nouvelles de vous depuis \(dates[3]), \(User.currentUser!.firstName) !"]
            notification30.alertBody = texts.shuffle().first!
            notification30.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification30)

        }
    }
}