//
//  workout.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/26/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//

import UIKit
import HealthKit

class WorkoutStartView: UIViewController {

    let healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SpeedySloth"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error
            
        }
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
        print("hi")
        }
    }
    
}


