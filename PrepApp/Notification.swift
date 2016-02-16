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
            //scheduling end of term local alerts
            //2 mois avant le concours, 1 mois et demi, 1 mois, 2 semaines, 1 semaines, 3 jours, jour J
            guard let endOfTerm = NSUserDefaults.standardUserDefaults().objectForKey("date") as? NSDate else { return }
            if endOfTerm.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                let delta: Double = 60*60*9
                let twoMonthsBeforeDate = NSDate(timeInterval: -day*61 + delta, sinceDate: endOfTerm)
                let oneMonthHalfBeforeDate = NSDate(timeInterval: -day*45 + delta, sinceDate: endOfTerm)
                let oneMonthBeforeDate = NSDate(timeInterval: -day*30 + delta, sinceDate: endOfTerm)
                let twoWeeksBeforeDate = NSDate(timeInterval: -day*14 + delta, sinceDate: endOfTerm)
                let oneWeekBeforeDate = NSDate(timeInterval: -day*7 + delta, sinceDate: endOfTerm)
                let threeDaysBeforeDate = NSDate(timeInterval: -day*3 + delta, sinceDate: endOfTerm)
                let eveDate = NSDate(timeInterval: -day*1 + delta, sinceDate: endOfTerm)
                let ddayDate = NSDate(timeInterval: delta, sinceDate: endOfTerm)
                //2months before
                if twoMonthsBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let twoMonthsBefore = UILocalNotification()
                    twoMonthsBefore.fireDate = twoMonthsBeforeDate
                    twoMonthsBefore.alertBody = "Votre échéance est fixée dans 2 mois... Entraînez-vous régulièrement !"
                    twoMonthsBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(twoMonthsBefore)
                    print("\(twoMonthsBefore.alertBody!) sera envoyé le \(twoMonthsBefore.fireDate!)")
                }
                //1month1/2
                if oneMonthHalfBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let oneMonthHalfBefore = UILocalNotification()
                    oneMonthHalfBefore.fireDate = oneMonthHalfBeforeDate
                    oneMonthHalfBefore.alertBody = "Plus qu'un mois et demi avant l'échéance... Lancez Prep'App !"
                    oneMonthHalfBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(oneMonthHalfBefore)
                    print("\(oneMonthHalfBefore.alertBody!) sera envoyé le \(oneMonthHalfBefore.fireDate!)")
                }
                //1month
                if oneMonthBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let oneMonthBefore = UILocalNotification()
                    oneMonthBefore.fireDate = oneMonthBeforeDate
                    oneMonthBefore.alertBody = "Plus qu'un mois avant l'échéance, ne lâchez rien !"
                    oneMonthBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(oneMonthBefore)
                    print("\(oneMonthBefore.alertBody!) sera envoyé le \(oneMonthBefore.fireDate!)")
                }
                //2weeks
                if twoWeeksBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let twoWeeksBefore = UILocalNotification()
                    twoWeeksBefore.fireDate = twoWeeksBeforeDate
                    twoWeeksBefore.alertBody = "Deux semaines avant l'échéance... Entraînez-vous !"
                    twoWeeksBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(twoWeeksBefore)
                    print("\(twoWeeksBefore.alertBody!) sera envoyé le \(twoWeeksBefore.fireDate!)")
                }
                //1week
                if oneWeekBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let oneWeekBefore = UILocalNotification()
                    oneWeekBefore.fireDate = oneWeekBeforeDate
                    oneWeekBefore.alertBody = "Votre échéance approche... plus qu'une semaine ! Redoublez d'efforts !"
                    oneWeekBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(oneWeekBefore)
                    print("\(oneWeekBefore.alertBody!) sera envoyé le \(oneWeekBefore.fireDate!)")
                }
                //3 days
                if threeDaysBeforeDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let threeDaysBefore = UILocalNotification()
                    threeDaysBefore.fireDate = threeDaysBeforeDate
                    threeDaysBefore.alertBody = "Plus que 3 jours avant l'échéance... Go, go, go !!!"
                    threeDaysBefore.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(threeDaysBefore)
                    print("\(threeDaysBefore.alertBody!) sera envoyé le \(threeDaysBefore.fireDate!)")
                }
                //eve
                if eveDate.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                    let eve = UILocalNotification()
                    eve.fireDate = eveDate
                    eve.alertBody = "Demain c'est le grand jour. Préparez-vous à réussir !"
                    eve.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().scheduleLocalNotification(eve)
                    print("\(eve.alertBody!) sera envoyé le \(eve.fireDate!)")
                }
                //D-day
                let dday = UILocalNotification()
                dday.fireDate = ddayDate
                dday.alertBody = "Aujourd'hui, c'est le grand jour. Bonne chance !"
                dday.soundName = UILocalNotificationDefaultSoundName
                UIApplication.sharedApplication().scheduleLocalNotification(dday)
                print("\(dday.alertBody!) sera envoyé le \(dday.fireDate!)")
            }
        }
    }
}