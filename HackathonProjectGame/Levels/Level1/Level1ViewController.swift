//
//  Level1ViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

var level2isOpen = 0
var balance = 100_000

struct DeviceJson: Codable {
    let id: Int
    let name: String
    let level: Int
    let price: Int
    let powerConsumption: Int
    let levelUpDevices: [DeviceJson]
    
    // Coding keys to match JSON keys with Swift properties
    enum CodingKeys: String, CodingKey {
        case id, name, level, price, levelUpDevices
        case powerConsumption = "power_consumption"
    }
}

class Level1ViewController: UIViewController {
    var counter = 1
    var deviceData: [DeviceJson] = []
    
    @IBOutlet weak var balanceText: UILabel!
    @IBOutlet weak var balanceView: UIView!
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
    
    override func viewWillAppear(_ animated: Bool) {
        balanceText.text = "\(balance)"
    }
    
    
    private func loadIconsForCurrentDevices() {
        boilerButton.setBackgroundImage(UIImage(named: "\(deviceData[3].name)"), for: .normal)
        boilerButton.layer.cornerRadius = 8
        addShadowAround(button: boilerButton)
        
        washButton.setBackgroundImage(UIImage(named: "\(deviceData[1].name)"), for: .normal)
        addShadowAround(button: washButton)
        
        fridgeButton.setBackgroundImage(UIImage(named: "\(deviceData[2].name)"), for: .normal)
        fridgeButton.layer.cornerRadius = 4
        addShadowAround(button: fridgeButton)
        
        
        lampSmallButton1.setBackgroundImage(UIImage(named: "\(deviceData[0].name)"), for: .normal)
        
        lampButton.setBackgroundImage(UIImage(named: "lampIcon"), for: .normal)
        //        lampButton.setBackgroundImage(UIImage(named: "lampIconLevel\(deviceData[3].level)"), for: .normal)
        addShadowAround(button: lampButton)
        
        balanceView.backgroundColor = .white
        balanceView.layer.borderColor = UIColor.newGreen.cgColor
        balanceView.layer.borderWidth = 2
        balanceView.layer.cornerRadius = 16
        
        checkButton.backgroundColor = .white
        checkButton.layer.borderColor = UIColor.newGreen.cgColor
        checkButton.layer.borderWidth = 2
        checkButton.layer.cornerRadius = 16
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
        self.navigationController?.pushViewController(CheckViewController(), animated: true)
    }
    
    @IBAction func boilerButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceType: .boiler,
                                                 currentDeviceData: deviceData[3],
                                                 newDevicesData: deviceData[3].levelUpDevices,
                                                 onBuyAction: { newDevicePosition in
            Task {
                do {
                    let parameter = "/\(self.deviceData[3].id)/\(self.deviceData[3].levelUpDevices[newDevicePosition].id)"
                    balance -= self.deviceData[3].levelUpDevices[newDevicePosition].price
                    self.deviceData = try await self.fetchUpgradeDevicesData(parameter: parameter)
                    self.balanceText.text = "\(balance)"
                    self.boilerButton.startLightningAnimation()
                    self.boilerButton.setBackgroundImage(UIImage(named: "\(self.deviceData[3].name)"), for: .normal)
                } catch {
                    print("Failed to fetch or parse data: \(error)")
                }
            }
        }), animated: true)
    }
    
    @IBAction func washButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceType: .wash,
                                                 currentDeviceData: deviceData[1],
                                                 newDevicesData: deviceData[1].levelUpDevices,
                                                 onBuyAction: { newDevicePosition in
            Task {
                do {
                    let parameter = "/\(self.deviceData[1].id)/\(self.deviceData[1].levelUpDevices[newDevicePosition].id)"
                    balance -= self.deviceData[1].levelUpDevices[newDevicePosition].price
                    self.deviceData = try await self.fetchUpgradeDevicesData(parameter: parameter)
                    self.balanceText.text = "\(balance)"
                    self.washButton.startLightningAnimation()
                    self.washButton.setBackgroundImage(UIImage(named: "\(self.deviceData[1].name)"), for: .normal)
                } catch {
                    print("Failed to fetch or parse data: \(error)")
                }
            }
        }), animated: true)
    }
    
    @IBAction func fridgeButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceType: .fridge,
                                                 currentDeviceData: deviceData[2],
                                                 newDevicesData: deviceData[2].levelUpDevices,
                                                 onBuyAction: { newDevicePosition in
            Task {
                do {
                    let parameter = "/\(self.deviceData[2].id)/\(self.deviceData[2].levelUpDevices[newDevicePosition].id)"
                    balance -= self.deviceData[2].levelUpDevices[newDevicePosition].price
                    self.deviceData = try await self.fetchUpgradeDevicesData(parameter: parameter)
                    self.balanceText.text = "\(balance)"
                    self.fridgeButton.startLightningAnimation()
                    self.fridgeButton.setBackgroundImage(UIImage(named: "\(self.deviceData[2].name)"), for: .normal)
                } catch {
                    print("Failed to fetch or parse data: \(error)")
                }
            }
        }), animated: true)
    }
    
    @IBAction func lampButtonAction(_ sender: Any) {
        self.present(DeviceDetailsViewController(currentDeviceType: .lamp,
                                                 currentDeviceData: deviceData[0],
                                                 newDevicesData: deviceData[0].levelUpDevices,
                                                 onBuyAction: { newDevicePosition in
            Task {
                do {
                    let parameter = "/\(self.deviceData[0].id)/\(self.deviceData[0].levelUpDevices[newDevicePosition].id)"
                    balance -= self.deviceData[0].levelUpDevices[newDevicePosition].price
                    self.deviceData = try await self.fetchUpgradeDevicesData(parameter: parameter)
                    self.balanceText.text = "\(balance)"
                    self.lampSmallButton1.startLightningAnimation()
                    self.lampSmallButton1.setBackgroundImage(UIImage(named: "\(self.deviceData[0].name)"), for: .normal)
                } catch {
                    print("Failed to fetch or parse data: \(error)")
                }
            }
        }), animated: true)
    }
    
    
    @IBAction func addMoney(_ sender: Any) {
        self.navigationController?.pushViewController(MiniGameViewViewController(), animated: true)
    }
    
    func fetchUpgradeDevicesData(parameter: String) async throws -> [DeviceJson] {
        try await fetch(from: apiLink + apiUpgrade + parameter)
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
