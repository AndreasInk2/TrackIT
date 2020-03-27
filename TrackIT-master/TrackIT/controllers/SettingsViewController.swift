//
//  settings.swift
//  TrackIT
//
//  Created by Laima Cernius-Ink on 3/25/20.
//  Copyright © 2020 Steve Ink. All rights reserved.
//

import UIKit
import CoreBluetooth
class settings: UIViewController {

    let home = UILabel()
        let lbl = UILabel()
    let lbl2 = UITextView()
     let lbl3 = UILabel()
       let screenSize: CGRect = UIScreen.main.bounds
       let view1 = UIView()
    
    var peripharalManger: CBPeripheralManager!
          private var service: CBUUID!
          private let value = "AD34"
         
          var centralManager:CBCentralManager!
          var periphiralDevice:CBPeripheral!
             
             var counter = 0
             var data  = [String]()
             var dicta = [String:String]()
             var dict = [[String:String]]()
    

    
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
        
        
       
               home.text =  "Settings"
                                                       home.textColor = .black
               home.frame.size.width = 200
                                                     home.frame.size.height = 75
                                              home.center.x = 130
                                                        home.center.y = 105
                                           //  home.font = UIFont(name: "Avenir Next", size: 60)
                                             home.font = .boldSystemFont(ofSize: 45)
                                            
                                         
                                                       view.addSubview(home)
        
        let defaults = UserDefaults.standard
                   let name = defaults.string(forKey: "name")
          let uuid = defaults.string(forKey: "uuid")
        if uuid == nil {
             defaults.set("unknown",forKey: "uuid")
        }
        lbl.text = "Name: " + "\(name ?? "Anonymous")"
         lbl.font = .boldSystemFont(ofSize: 20)
       
       
        lbl.frame.size.width = 300
        lbl.frame.size.height = 100
        lbl.center.x = view.center.x
               lbl.center.y = home.center.y + 140
        lbl.textColor = .black
        
        view.addSubview(lbl)
        print(uuid)
        let uuid2 = uuid!.replacingOccurrences(of: "Optional(", with: "", options: NSString.CompareOptions.literal, range: nil)
                      let uuid3 = uuid2.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
        lbl2.text = "Device uuid: " + "\(uuid3 ?? "unknown")"
         lbl2.font = .boldSystemFont(ofSize: 20)
        
       
           
        lbl2.textColor = .black
        lbl2.frame.size.width = 300
        lbl2.frame.size.height = 175
        lbl2.isEditable = false
        lbl2.center.x = view.center.x
               lbl2.center.y = lbl.center.y + 100
        view.addSubview(lbl2)
         lbl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
         lbl2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        lbl2.backgroundColor = .clear
        view1.layer.cornerRadius = 20
        view1.frame.size.width = screenWidth - 60
                            view1.frame.size.height = 100
                           view1.center.x = view.center.x
                            view1.center.y = lbl2.center.y + 110
                           view1.backgroundColor = color1
                           view.addSubview(view1)
        
        lbl3.text = "Disable Background Refresh"
          lbl3.font = .boldSystemFont(ofSize: 20)
         
        
            
         lbl3.textColor = .white
        lbl3.frame.size.width = 300
         lbl3.frame.size.height = 100
         
         lbl3.center.x = 167
                lbl3.center.y = 50
         view1.addSubview(lbl3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
                   
                    view1.addGestureRecognizer(tap)
    }
    
    @objc func taped() {
        
        let defaults = UserDefaults.standard
        let enabledBackground = defaults.bool(forKey: "enabledBackground")
        
        if enabledBackground == nil {
              defaults.set(true,forKey: "enabledBackground")
              lbl3.text = "Disable Background Refresh"
        }
        if enabledBackground == true {
              defaults.set(false,forKey: "enabledBackground")
              lbl3.text = "Disable Background Refresh"
        }
        if enabledBackground == false {
            defaults.set(true,forKey: "enabledBackground")
              lbl3.text = "Enable Background Refresh"
        }
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

extension settings: CBPeripheralManagerDelegate {
    
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
        let defaults = UserDefaults.standard
                  
        defaults.set("\(String(describing: service))",forKey: "uuid")
        startAdvertising()

    }
    
    func startAdvertising() {
        
        
        peripharalManger.startAdvertising([CBAdvertisementDataLocalNameKey : "BLE-APP-\(randomString(length: 10))", CBAdvertisementDataServiceUUIDsKey :     [service]])
    print("Started Advertising")
        
    }
}


extension settings: CBCentralManagerDelegate {
   
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
            defaults.set([uuidString, uuidContactWith as Any],forKey: "uuidContactWith")
            
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
