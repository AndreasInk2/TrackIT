import UIKit

class ColorSwitchViewController: UIViewController {

    @IBOutlet weak var connectionsLabel: UILabel!

    let colorService = ColorService()

    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self

          let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                  let defaults = UserDefaults.standard
          let status = defaults.string(forKey: "status")
                  print(status)
                  if status == "connected" {
                      self.view.backgroundColor = .green
                  }
                  if status == "none" {
                      self.view.backgroundColor = .white
                  }
      }
      }
    

    @IBAction func redTapped() {
       
        colorService.send(colorName: "red")
    }

    @IBAction func yellowTapped() {
        self.change(color: .yellow)
        colorService.send(colorName: "yellow")
    }

    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

extension ColorSwitchViewController : ColorServiceDelegate {

    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }

    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "connected":
               break
            case "yellow":
            break
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

}
