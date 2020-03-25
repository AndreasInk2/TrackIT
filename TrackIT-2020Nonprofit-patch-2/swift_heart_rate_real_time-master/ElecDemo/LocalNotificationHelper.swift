//
//  LocalNotificationHelper.swift
//  ElecDemo
//
//  Created by NhatHM on 8/12/19.
//  Copyright © 2019 GST.PID. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationHelper {
   let colorService = ColorService()
    static func requestPermission() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Granted")
            } else {
                print("Not Granted")
            }
        }
    }
    
    static func fireHeartRate(_ heartRate: Double) {
        let center = UNUserNotificationCenter.current()
        
       
        WorkoutTracking.shared.observerHeartRateSamples()
       
       

    }

}
