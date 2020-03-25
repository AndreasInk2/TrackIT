//
//  ViewController.swift
//  ElecDemo
//
//  Created by NhatHM on 8/9/19.
//  Copyright © 2019 GST.PID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var heartRateLvl = 0
    var sent = 0
     let colorService = ColorService()
    var namesOfPeopleAround = [""]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                             self.view.backgroundColor = .green
                            
                         }
                    if self.namesOfPeopleAround.contains("iPhone") {
                        self.sent += 1
                                   if self.sent == 1 {
                                   self.view.backgroundColor = .red
                                   
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
                                                      self.view.backgroundColor = .red
                                                      
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
                                        self.view.backgroundColor = .white
                                    }
                        }
                    
                 //   defaults.set("nameOfInfectedPerson", forKey: "status")
                   
                        
         let timer3 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
           self.colorService.delegate = self
            self.colorService.send(colorName: "red")
        }
             }
           

    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WorkoutTracking.shared.authorizeHealthKit()
        WorkoutTracking.shared.observerHeartRateSamples()
        WatchKitConnection.shared.delegate = self
         let defaults = UserDefaults.standard
        defaults.set("none", forKey: "status")
    }
}

extension ViewController: WatchKitConnectionDelegate {
    func didFinishedActiveSession() {
        WatchKitConnection.shared.sendMessage(message: ["username" : "nhathm" as AnyObject])
    }
}
extension ViewController : ColorServiceDelegate {

    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
           print( "Connections: \(connectedDevices)")
            self.namesOfPeopleAround = connectedDevices
        }
    }

    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                let defaults = UserDefaults.standard
                                       
                                                
                                                 
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
