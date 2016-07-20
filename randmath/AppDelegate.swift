//
//  AppDelegate.swift
//  randmath
//
//  Created by Vineeth Vijayan on 16/04/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let textAction = UIMutableUserNotificationAction()
        textAction.identifier = "TEXT_ACTION"
        textAction.title = "Reply"
        textAction.activationMode = .Background
        textAction.authenticationRequired = false
        textAction.destructive = false
        textAction.behavior = .TextInput
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "CATEGORY_ID"
        category.setActions([textAction], forContext: .Default)
        category.setActions([textAction], forContext: .Minimal)
        
        let categories = NSSet(object: category) as! Set<UIUserNotificationCategory>
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        
//        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        
        let reply = responseInfo[UIUserNotificationActionResponseTypedTextKey] as! String

        NSUserDefaults.standardUserDefaults().setObject(reply, forKey: "answerKey")
        
        var message = ""
        
        print(identifier)
        print(responseInfo)
        print(reply)
        
        if let savedValue = NSUserDefaults.standardUserDefaults().stringForKey("expectedAnswerKey") {
            if savedValue == reply{
                message = "Correct"
            }
            else{
                message = "Wrong"
            }
        }
        
        let now: NSDateComponents = NSCalendar.currentCalendar().components([.Hour, .Minute], fromDate: NSDate())
        
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let date = cal.dateBySettingHour(now.hour, minute: now.minute + 1, second: now.second, ofDate: NSDate(), options: NSCalendarOptions())
        let reminder = UILocalNotification()
        reminder.fireDate = date
        reminder.alertBody = message
        reminder.alertAction = "Cool"
        reminder.soundName = "sound.aif"
        reminder.category = "REPLY_ID"
        
        UIApplication.sharedApplication().scheduleLocalNotification(reminder)
    }

}

