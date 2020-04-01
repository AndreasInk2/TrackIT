//
//  AppDelegate.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        FirebaseApp.configure()

        let db = Firestore.firestore()
        
        //findPulseTime
        
        let docRef = db.collection("sync").document("pulse")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("\(dataDescription)")
                let text2 = dataDescription.replacingOccurrences(of: "[\"pulseTime\": ", with: "", options: NSString.CompareOptions.literal, range: nil)
                               let text3 = text2.replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)
                     // 2040
                //setPulseTime
                if 60 > Double(text3)! {
                     UIApplication.shared.setMinimumBackgroundFetchInterval(Double(text3 )! + 60)
                }
               
                if 60 < Double(text3)! {
                         UIApplication.shared.setMinimumBackgroundFetchInterval(Double(text3 )!)
                }
            } else {
                print("Document does not exist")
            }
        }
     

        return true
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
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
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
       
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
            // Fallback on earlier versions
        }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

