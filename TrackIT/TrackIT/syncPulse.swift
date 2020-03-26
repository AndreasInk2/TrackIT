//
//  syncPulse.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//

import UIKit
import Firebase
class syncPulse: UIViewController {

    var time = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
          let db = Firestore.firestore()
            self.time += 5
            print(self.time)
            if 60 - self.time < 0 {
                self.time = 0
            }
        db.collection("sync").document("pulse").setData([
            "pulseTime": 60 - self.time,
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
