//
//  Level1ViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

struct DeviceJson: Codable {
    let id: Int
    let name: String
    let level: Int
    let price: Int
    let levelUpDevices: [DeviceJson]
    
    // Coding keys to match JSON keys with Swift properties
    //    enum CodingKeys: String, CodingKey {
    //        case id, name, level
    //        case isAvailable = "is_available"
    //    }
}

class Level1ViewController: UIViewController {
    var counter = 1
    var deviceData: [DeviceJson] = []
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var boilerButton: UIButton!
    @IBOutlet weak var washButton: UIButton!
    @IBOutlet weak var fridgeButton: UIButton!
    @IBOutlet weak var lampButton: UIButton!
    
    @IBOutlet weak var lampSmallButton1: UIButton!
    
    @IBOutlet weak var lvl1Bg: UIImageView!
    
    convenience init(data: [DeviceJson]) {
        self.init()
        self.deviceData = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lvl1Bg.image = UIImage(resource: .level1Bg)
        loadIconsForCurrentDevices()
    }
    
    
    private func loadIconsForCurrentDevices() {
        boilerButton.setBackgroundImage(UIImage(named: "boilerIconLevel\(deviceData[0].level)"), for: .normal)
        addShadowAround(button: boilerButton)
        
        washButton.setBackgroundImage(UIImage(named: "washIconLevel\(deviceData[1].level)"), for: .normal)
        addShadowAround(button: washButton)
        
        fridgeButton.setBackgroundImage(UIImage(named: "fridgeIconLevel\(deviceData[2].level)"), for: .normal)
        fridgeButton.layer.cornerRadius = 4
        addShadowAround(button: fridgeButton)
        
        lampButton.setBackgroundImage(UIImage(named: "lampIcon"), for: .normal)
//        lampButton.setBackgroundImage(UIImage(named: "lampIconLevel\(deviceData[3].level)"), for: .normal)
        addShadowAround(button: lampButton)
    }
    
    func addShadowAround(button: UIButton) {
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        button.layer.shadowOpacity = 5.0
        button.layer.shadowOffset = CGSize(width: 12, height: 3)
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        //open check window
    }
    
    @IBAction func boilerButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceData: deviceData[0],
                                                 newDevicesData: deviceData[0].levelUpDevices,
                                                 onBuyAction: {
            self.boilerButton.startLightningAnimation()
            self.boilerButton.setBackgroundImage(UIImage(named: "boilerIconLevel\(self.deviceData[0].level + 1)"), for: .normal)
        }), animated: true)
    }
    
    @IBAction func washButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceData: deviceData[1],
                                                 newDevicesData: deviceData[1].levelUpDevices,
                                                 onBuyAction: {
            self.washButton.startLightningAnimation()
            self.washButton.setBackgroundImage(UIImage(named: "washIconLevel\(self.deviceData[1].level + 1)"), for: .normal)
        }), animated: true)
    }
    
    @IBAction func fridgeButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceData: deviceData[2],
                                                 newDevicesData: deviceData[2].levelUpDevices,
                                                 onBuyAction: {
            self.fridgeButton.startLightningAnimation()
            self.fridgeButton.setBackgroundImage(UIImage(named: "fridgeIconLevel\(self.deviceData[2].level + 1)"), for: .normal)
        }), animated: true)
    }
    
    @IBAction func lampButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceData: deviceData[3],
                                                 newDevicesData: deviceData[3].levelUpDevices,
                                                 onBuyAction: {
            self.lampSmallButton1.startLightningAnimation()
            self.lampSmallButton1.setBackgroundImage(UIImage(named: "lampIconLevel\(self.deviceData[3].level + 1)"), for: .normal)
        }), animated: true)
    }
    
}

extension UIButton {
    func startLightningAnimation() {
//        flashAnimation()
        shakeAnimation()
        scaleAnimation()
    }
    
    // Flash Animation (changing colors quickly to simulate lightning)
    private func flashAnimation() {
        let flash = CABasicAnimation(keyPath: "backgroundColor")
        flash.fromValue = UIColor.white.cgColor // Flash to white
        flash.toValue = UIColor.yellow.cgColor // Back to original color (black or button color)
        flash.duration = 0.1 // Quick flash duration
        flash.autoreverses = true // Flash back and forth
        flash.repeatCount = 3 // Repeat flash a few times
        
        layer.add(flash, forKey: nil)
    }
    
    // Shake Animation (subtle shake to simulate lightning jolt)
    private func shakeAnimation() {
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.timingFunction = CAMediaTimingFunction(name: .linear)
        shake.values = [-10, 10, -8, 8, -5, 5, 0] // Shake values to move left and right
        shake.duration = 0.4 // Duration of the shake
        
        layer.add(shake, forKey: nil)
    }
    
    // Scale Animation (button shrinks and expands)
    private func scaleAnimation() {
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1.0 // Start at normal size
        scale.toValue = 1.1 // Slightly bigger size
        scale.duration = 0.4 // Same duration as the shake
        scale.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut) // EaseInOut for smooth effect
        scale.autoreverses = true // Go back to normal size
        scale.repeatCount = 1 // Only repeat once
        
        layer.add(scale, forKey: nil)
    }
}
