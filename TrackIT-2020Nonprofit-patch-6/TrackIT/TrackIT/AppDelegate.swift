//
//  AppDelegate.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//




import UIKit
import BackgroundTasks
import CoreBluetooth
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
    }
    

    private var centralManager : CBCentralManager!
    func scheduleImagefetcher() {
    let request = BGProcessingTaskRequest(identifier: "com.SO.imagefetcher")
    request.requiresNetworkConnectivity = false // Need to true if your task need to network process. Defaults to false.
    request.requiresExternalPower = false
    //If we keep requiredExternalPower = true then it required device is connected to external power.

    request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // fetch Image Count after 1 minute.
    //Note :: EarliestBeginDate should not be set to too far into the future.
    do {
    try BGTaskScheduler.shared.submit(request)
    } catch {
    print("Could not schedule image fetch: (error)")
    }
    }

    func scheduleAppRefresh() {
   
    }
    
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    registerBackgroundTaks()
centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    let center = UNUserNotificationCenter.current()
                 
                 center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                 }
    return true
    }

    //MARK: Register BackGround Tasks
    private func registerBackgroundTaks() {

    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.SO.imagefetcher", using: nil) { task in
    //This task is cast with processing request (BGProcessingTask)
        
        let center = UNUserNotificationCenter.current()
        // MARK: UISceneSession Lifecycle
        let content = UNMutableNotificationContent()
              content.title = "Hey I'm a notification!"
              content.body = "Look at me!"
              
              // Step 3: Create the notification trigger
              let date = Date().addingTimeInterval(10)
              
              let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
              
              let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
              
              // Step 4: Create the request
              
              let uuidString = UUID().uuidString
              
              let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
              
              // Step 5: Register the request
              center.add(request) { (error) in
                  // Check the error parameter and handle any errors
              }
        }

    
    func applicationDidEnterBackground(_ application: UIApplication) {
    scheduleAppRefresh()
    scheduleImagefetcher()
    }


 
    func cancelAllPendingBGTask() {
    BGTaskScheduler.shared.cancelAllTaskRequests()
    }
}
}
