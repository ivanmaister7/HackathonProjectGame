//
//  DeviceDetailsViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 22.09.2024.
//

import UIKit
enum DeviceType {
    case lamp, boiler, wash, fridge
    
    init(_ elem: Int) {
        switch elem {
        case 0:
            self = .lamp
        case 1:
            self = .wash
        case 2:
            self = .fridge
        case 3:
            self = .boiler
        default:
            self = .lamp
        }
    }
}

class DeviceDetailsViewController: UIViewController {
    
    private var deviceType: DeviceType = .lamp
    private let cellId = String(describing: DeviceDetailsViewCollectionViewCell.self)
    private var newDevicesData: [DeviceJson] = []
    private var currentDeviceData: DeviceJson = DeviceJson(id: 0, name: "", level: 0, price: 0, powerConsumption: 34, levelUpDevices: [])
    private var onBuyAction: (Int) -> () = { _ in }

    @IBOutlet weak var devicesNewStackView: UICollectionView!
    @IBOutlet weak var deviceCurrentLevelInfoView: DeviceDetailsView!
    
    convenience init(currentDeviceType: DeviceType, currentDeviceData: DeviceJson, newDevicesData: [DeviceJson], onBuyAction: @escaping (Int) -> ()) {
        self.init()
        self.currentDeviceData = currentDeviceData
        self.deviceType = currentDeviceType
        self.newDevicesData = newDevicesData
        self.onBuyAction = onBuyAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .menuBlue.withAlphaComponent(0.7)
        
        deviceCurrentLevelInfoView.configure(currentDeviceData, deviceType)
        
        self.devicesNewStackView.dataSource = self
        self.devicesNewStackView.delegate = self
        self.devicesNewStackView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        self.devicesNewStackView.backgroundColor = .clear
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension DeviceDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.newDevicesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = devicesNewStackView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DeviceDetailsViewCollectionViewCell
        let cellModel = newDevicesData[indexPath.row]
        cell.configure(cellModel, deviceType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.onBuyAction(indexPath.row)
        level2isOpen += 1
        
        self.dismiss(animated: true)
        
//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.pushViewController(getViewController(forLevel: indexPath.row), animated: true)
    }
}

extension DeviceDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.deviceCurrentLevelInfoView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
