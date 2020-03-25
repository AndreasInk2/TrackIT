//
//  AppDelegate.swift
//  ElecDemo
//
//  Created by NhatHM on 8/9/19.
//  Copyright © 2019 GST.PID. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
var sent = 0
    var heartRateLvl = 0
     var namesOfPeopleAround = [""]
    var window: UIWindow?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
  let colorService = ColorService()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
          let defaults = UserDefaults.standard
        defaults.set(0.0, forKey: "heartRate")
        LocalNotificationHelper.requestPermission()
       // defaults.set("none", forKey: "status")
        WatchKitConnection.shared.startSession()
     //   colorService.delegate = self
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        return true
    }
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     colorService.delegate = self
    
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                          let defaults = UserDefaults.standard
                  let heartRate = defaults.double(forKey: "heartRate")
               print(self.heartRateLvl)
                          if heartRate > 76 {
                           self.heartRateLvl += 1
                          }
                          if heartRate < 76  {
                           self.heartRateLvl = 0
                          }
               if self.heartRateLvl > 7200 {
                   print("prolonged_Heartrate_Elevation")
               }
              }
         

                    let timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                            let defaults = UserDefaults.standard
                    let status = defaults.string(forKey: "status")
                       let hasComeInContact = defaults.string(forKey: "hasComeInContact")
                           print(hasComeInContact)
                            if status == "connected" {
                               
                               
                            }
                       if self.namesOfPeopleAround.contains("iPhone") {
                           self.sent += 1
                                      if self.sent == 1 {
                                    
                                      
                                       let center = UNUserNotificationCenter.current()
                                      let content = UNMutableNotificationContent()
                                           content.title = "Urgent Alert"
                                           content.body = "You may have come in contact with someone who is sick, please self quarantine."
                                           
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
                                  }
                                  if self.sent == 1800 {
                                                        
                                                         
                                                          let center = UNUserNotificationCenter.current()
                                                         let content = UNMutableNotificationContent()
                                                              content.title = "Urgent Alert"
                                                              content.body = "You may have come in contact with someone who is sick, please self quarantine."
                                                              
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
                                                     
                                       if status == "none" {
                                          
                                       }
                           }
                       
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        backgroundTask = UIApplication.shared.beginBackgroundTask { [unowned self] in
            //            UIApplication.shared.endBackgroundTask(backgroundTask)
           /// self.colorService.delegate = self
            //            self?.backgroundTask = .invalid
            UIApplication.shared.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate : ColorServiceDelegate {

    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
           print( "Connections: \(connectedDevices)")
        }
    }

    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                let defaults = UserDefaults.standard
                                       
                                                
                                                 var status =  defaults.string(forKey: "status")
                defaults.set("connected", forKey: "status")
                
                
               break
            case "yellow":
            break
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

}
