//
//  settings.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//

import UIKit

class settings: UIViewController {

    let home = UILabel()
        let lbl = UILabel()
       let screenSize: CGRect = UIScreen.main.bounds
       let view1 = UIView()
    
    func hexStringToUIColor (hex:String) -> UIColor {
         var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

         if (cString.hasPrefix("#")) {
             cString.remove(at: cString.startIndex)
         }

         if ((cString.count) != 6) {
             return UIColor.gray
         }

         var rgbValue:UInt64 = 0
         Scanner(string: cString).scanHexInt64(&rgbValue)

         return UIColor(
             red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
             alpha: CGFloat(1.0)
         )
     }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = screenSize.width
                              let screenHeight = screenSize.height
        
        let color1 = hexStringToUIColor(hex: "#2792FF")
        let color2 = hexStringToUIColor(hex: "#7EBFFF")
        
        
       
               home.text =  "Settings"
                                                       home.textColor = .black
               home.frame.size.width = 200
                                                     home.frame.size.height = 75
                                              home.center.x = 130
                                                        home.center.y = 90
                                           //  home.font = UIFont(name: "Avenir Next", size: 60)
                                             home.font = .boldSystemFont(ofSize: 45)
                                            
                                         
                                                       view.addSubview(home)
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
