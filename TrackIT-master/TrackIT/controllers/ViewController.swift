//
//  ViewController.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//


import UIKit
import CoreBluetooth
import Lottie
class ViewController: UIViewController {

    let animationView = AnimationView()
      let home = UILabel()
     let lbl = UILabel()
    let screenSize: CGRect = UIScreen.main.bounds
    let view1 = UIView()
    let view2 = UIView()
    let view3 = UIView()
    let view4 = UIView()
     let lbl1 = UITextView()
    let lbl2 = UITextView()
    let lbl3 = UITextView()
    let lbl4 = UITextView()
   var mLabelForUpdate = UILabel()
    let description1 = UITextView()
    let description2 = UITextView()
    let description3 = UITextView()
    let description4 = UITextView()
    
    var peripharalManger: CBPeripheralManager!
       private var service: CBUUID!
       private let value = "AD34"
      
       var centralManager:CBCentralManager!
       var periphiralDevice:CBPeripheral!
          
          var counter = 0
          var data  = [String]()
          var dicta = [String:String]()
          var dict = [[String:String]]()
    
    var panGesture2 = UIPanGestureRecognizer()
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)

        peripharalManger = CBPeripheralManager(delegate: self, queue: nil)
        
        let screenWidth = screenSize.width
                              let screenHeight = screenSize.height
        
        let color1 = hexStringToUIColor(hex: "#2792FF")
        let color2 = hexStringToUIColor(hex: "#7EBFFF")
        
        
        home.text =  "Home"
                                                home.textColor = .black
        home.frame.size.width = 200
                                              home.frame.size.height = 75
                                       home.center.x = 130
                                                 home.center.y = 105
                                    //  home.font = UIFont(name: "Avenir Next", size: 60)
                                      home.font = .boldSystemFont(ofSize: 45)
                                     
                                  
                                                view.addSubview(home)
         let animation = Animation.named("lf30_editor_SKZ870", subdirectory: "")
           
           animationView.animation = animation
           animationView.contentMode = .scaleAspectFit
           animationView.frame.size.width = 400
              animationView.frame.size.height = 400
           animationView.center.x = view.center.x
            animationView.center.y = view.center.y
         
           view.addSubview(animationView)
         
           lbl.text = "Active"
            lbl.font = .boldSystemFont(ofSize: 20)
           lbl.sizeToFit()
           lbl.center.x = view.center.x
           lbl.center.y = view.center.y
              
           lbl.textColor = .white
           
           view.addSubview(lbl)
        
        view1.layer.cornerRadius = 20
                    view2.layer.cornerRadius = 20
                    view3.layer.cornerRadius = 20
                    view4.layer.cornerRadius = 20
        
        view1.frame.size.width = screenWidth - 50
           view1.frame.size.height = 200
          view1.center.x = view.center.x
           view1.center.y = animationView.center.y + 250
          view1.backgroundColor = color1
       //   view.addSubview(view1)
          
        
          
          
          view2.frame.size.width = screenWidth - 50
           view2.frame.size.height = 200
          view2.center.x = view.center.x
           view2.center.y = view1.center.y + 250
          view2.backgroundColor = color1
        //  view.addSubview(view2)
          
          view3.frame.size.width = screenWidth - 50
                      view3.frame.size.height = 200
                     view3.center.x = view.center.x
                      view3.center.y = view2.center.y + 250
                     view3.backgroundColor = color1
                  //   view.addSubview(view3)
          
          
          view4.frame.size.width = screenWidth - 50
                      view4.frame.size.height = 200
                     view4.center.x = view.center.x
                      view4.center.y = view3.center.y + 250
                     view4.backgroundColor = color1
                        //    view.addSubview(view4)
        
        lbl1.isEditable = false
        lbl2.isEditable = false
        lbl3.isEditable = false
        lbl4.isEditable = false
        lbl1.text = "Why do we collect your data?"
                           lbl1.textColor = .white
        lbl1.backgroundColor = .clear
         lbl1.font = .boldSystemFont(ofSize: 24)
        lbl1.frame.size.width = screenWidth - 70
        lbl1.frame.size.height = 170
                  lbl1.center.x = view.center.x - 10
                            lbl1.center.y = 90
                 
                
                 view1.addSubview(lbl1)
                 
                 lbl2.text = "What data do we collect?"
                 lbl2.textColor = .white
        lbl2.backgroundColor = .clear
        lbl2.frame.size.width = screenWidth - 70
        lbl2.frame.size.height = 170
                 lbl2.center.x = view.center.x - 20
                 lbl2.center.y = 90
                
                 lbl2.font = .boldSystemFont(ofSize: 24)
                 
                
                           view2.addSubview(lbl2)
                 
                 lbl3.text = "Who recieves my data?"
                               lbl3.textColor = .white
                                 lbl3.backgroundColor = .clear
                                 lbl3.frame.size.width = screenWidth - 70
                                 lbl3.frame.size.height = 170
                                          lbl3.center.x = view.center.x - 10
                                          lbl3.center.y = 90
                                         
                                          lbl3.font = .boldSystemFont(ofSize: 24)
                            
                            
                                      view3.addSubview(lbl3)
                            
                 
                 lbl4.text = "How do you secure my data?"
                 lbl4.textColor = .white
                      lbl4.backgroundColor = .clear
                      lbl4.frame.size.width = screenWidth - 70
                      lbl4.frame.size.height = 170
        lbl4.center.x = view.center.x - 10
                               lbl4.center.y = 90
                              
                               lbl4.font = .boldSystemFont(ofSize: 24)
                 
                 
                
                           view4.addSubview(lbl4)
          
        
        panGesture2 = UIPanGestureRecognizer(target: self, action: #selector(ViewController.draggedView2(_:)))
                                            view.isUserInteractionEnabled = true
                              view.addGestureRecognizer(panGesture2)
        
        description1.text = "We strive to enable healthcare officals to save lives all with your help!"
                  description1.textColor = .white
        description1.frame.size.width = 290
        description1.frame.size.height = 125
                  description1.center.x = view.center.x - 20
                  description1.center.y = 125
                  
                 
                  description1.font = .systemFont(ofSize: 20)
                  description1.backgroundColor = .clear
                  description1.isEditable = false
                            view1.addSubview(description1)
                  
                  
                  description2.text = "We collect the userid’s of users you have been in contact with and..."
                  description2.textColor = .white
        description2.frame.size.width = 290
          description2.frame.size.height = 125
        
                  description2.center.x = view.center.x - 20
                  description2.center.y = 100
                  
                  description2.font = .systemFont(ofSize: 20)
                  description2.backgroundColor = .clear
                  
                            view2.addSubview(description2)
                   description2.isEditable = false
                  description3.text = "Health officals such as WHO and the CDC among other officals recieve your data nonivasivly and securely. "
                  description3.textColor = .white
        description3.frame.size.width = 290
        description3.frame.size.height = 125
                  description3.center.x = view.center.x - 20
                  description3.center.y = 105
                  
                  
                  description3.font = .systemFont(ofSize: 20)
                  description3.backgroundColor = .clear
                            view3.addSubview(description3)
                  description3.isEditable = false
                  description4.text = "We secure our data with..."
                  description4.textColor = .white
        description4.frame.size.width = 290
                          description4.frame.size.height = 125
                  description4.center.x = view.center.x - 20
                  description4.center.y = 125
                 
                 
                  description4.font = .systemFont(ofSize: 20)
                  description4.backgroundColor = .clear
                  description4.isEditable = false
                            view4.addSubview(description4)
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      animationView.play(fromProgress: 0,
                         toProgress: 1,
                         loopMode: LottieLoopMode.loop,
                         completion: { (finished) in
                          if finished {
                            print("Animation Complete")
                          } else {
                            print("Animation cancelled")
                          }
      })
        let screenWidth = screenSize.width
                              let screenHeight = screenSize.height
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
             if self.home.center.y > 105 {
             
            
                                                      self.home.center.y = 105
             
            
           
           }
            
            if self.home.center.y < -800 {
              
             
                                                       self.home.center.y = -700
              
             
            
            }
             }
      
    }
    @objc func draggedView2(_ sender:UIPanGestureRecognizer){
               let screenWidth = screenSize.width
                       let screenHeight = screenSize.height
     
       
             //if viewDragLong == true {
                 //self.view.bringSubviewToFront(planet)
                let translation = sender.translation(in: self.view)
                    //  one.center = CGPoint(x: one.center.x, y: one.center.y + translation.y )
                sender.setTranslation(CGPoint.zero, in: self.view)
            
       UIView.animate(withDuration: 0.4,
                           delay: 0.0,
                           options: [],
                           animations: { [weak self] in
                          //  self!.home.center = CGPoint(x: self!.home.center.x, y: self!.home.center.y + translation.y * 1.7 )
                               
                             
              }, completion: nil)
                  
              UIView.animate(withDuration: 0.4,
                                  delay: 0.05,
                                  options: [],
                                  animations: { [weak self] in
                                      
                                    
                     }, completion: nil)
                         
                     UIView.animate(withDuration: 0.3,
                                         delay: 0.1,
                                         options: [],
                                         animations: { [weak self] in
                                           
                                            
                                           
                            }, completion: nil)
                                
                            
     UIView.animate(withDuration: 0.4,
                                            delay: 0.15,
                                            options: [],
                                            animations: { [weak self] in
                                                
                                               
                                              
                               }, completion: nil)
        UIView.animate(withDuration: 0.4,
                                               delay: 0.2,
                                               options: [],
                                               animations: { [weak self] in
                                                
                                                  
                                                 
                                  }, completion: nil)
          
                                 UIView.animate(withDuration: 0.3,
                                              delay: 0.25,
                                              options: [],
                                              animations: { [weak self] in
                                               self!.view4.center.y = self!.view3.center.y + 250
                                                 
                                                
                                 }, completion: nil)
                                       
                                 
                                       
                                  
           
                
           //  }/
    }
    
}

extension ViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    switch peripheral.state {
        
        case .unknown:
            print("Bluetooth Device is UNKNOWN")
        case .unsupported:
            print("Bluetooth Device is UNSUPPORTED")
        case .unauthorized:
            print("Bluetooth Device is UNAUTHORIZED")
        case .resetting:
            print("Bluetooth Device is RESETTING")
        case .poweredOff:
            print("Bluetooth Device is POWERED OFF")
        case .poweredOn:
            print("Bluetooth Device is POWERED ON")
            addServices()
        @unknown default:
            print("Unknown State")
        }
    }
    
    

    
    func addServices() {
        
        let valueData = value.data(using: .utf8)
         // 1. Create instance of CBMutableCharcateristic
        let myChar1 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.notify, .write, .read], value: nil, permissions: [.readable, .writeable])
        let myChar2 = CBMutableCharacteristic(type: CBUUID(nsuuid: UUID()), properties: [.read], value: valueData, permissions: [.readable])
        // 2. Create instance of CBMutableService
        service = CBUUID(nsuuid: UUID())
        let myService = CBMutableService(type: service, primary: true)
        // 3. Add characteristics to the service
        myService.characteristics = [myChar1, myChar2]
        // 4. Add service to peripheralManager
        peripharalManger.add(myService)
        // 5. Start advertising
        
        print("UUID service: \(service!)")
        startAdvertising()

    }
    
    func startAdvertising() {
        peripharalManger.startAdvertising([CBAdvertisementDataLocalNameKey : "BLE-APP-\(randomString(length: 10))", CBAdvertisementDataServiceUUIDsKey :     [service]])
    print("Started Advertising")
        
    }
}


extension ViewController: CBCentralManagerDelegate {
   
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            
        case .unknown:
            print("Central code is unknown")
        case .resetting:
            print("Central code is resetting")
        case .unsupported:
            print("Central code is unsupported")
        case .unauthorized:
            print("Central code is unauthorized")
        case .poweredOff:
            print("Central code is powerdOff")
        case .poweredOn:
            print("Central code is powerOn")
            
            centralManager.scanForPeripherals(withServices: [CBUUID(string: "0000180F-0000-1000-8000-00805F9B34FB")], options: nil)

            
            let timer = Timer.scheduledTimer(timeInterval: 3.0,
            target: self,
            selector: Selector(("scan")),
            userInfo: nil,
            repeats: true)
            
            timer.fire()
        
            

        @unknown default:
            print("Default")
        }
    }
    
    @objc func scan(){
        centralManager.scanForPeripherals(withServices: nil)

    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        periphiralDevice = peripheral
        
        let uuidString = periphiralDevice.identifier.uuidString
        let peripharalName  = periphiralDevice.name
    
        //Add scanned data to array and count data every 10 inputs
        if !data.contains(uuidString){
            data.append(uuidString)
            
            dicta["name"] = peripharalName
            dicta["uuid"] = uuidString
            let defaults = UserDefaults.standard
            let uuidContactWith = defaults.array(forKey: "uuidContactWith")
            defaults.set([uuidString, uuidContactWith as Any ],forKey: "uuidContactWith")
            
            print("Saved:" + "\(uuidContactWith)")
            dict.append(dicta)
        }
                
        if data.count >=  10 {
            print("Data count \(data.count), ckeared")
            data = []
        }
        
        print("As array \n")
        print(data)
        print("********************************** \n")
        print("Print as array of dictionaries \n")
        print(dict)
        
        mLabelForUpdate.text = "\(dict)"
        mLabelForUpdate.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        print("\nName   : \(peripheral.name ?? "(No name)")")
        print("RSSI   : \(RSSI)")
        for ad in advertisementData {
            print("AD Data: key \(ad.key) value: \(ad.value)")
        }
        
        central.stopScan()
        
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }

    

}
