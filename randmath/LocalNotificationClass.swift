//
//  LocalNotificationClass.swift
//  randmath
//
//  Created by Vineeth Vijayan on 22/07/16.
//  Copyright © 2016 Vineeth Vijayan. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions
import SwiftRandom

func scheduleLocalNotification(message: String, date: NSDate, sound: String, category: String) {
    UIApplication.sharedApplication().cancelAllLocalNotifications()
    
    let notif = UILocalNotification()
    notif.fireDate = date
    notif.alertBody = Randoms.randomFakeName()
    notif.alertAction = "Cool"
    notif.soundName = sound
    notif.category = category
//    notif.repeatInterval = NSCalendarUnit.Minute
    
    UIApplication.sharedApplication().scheduleLocalNotification(notif)
    
}
