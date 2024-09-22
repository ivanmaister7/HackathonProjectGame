//
//  DeviceDetailsViewCollectionViewCell.swift
//  HackathonProjectGame
//
//  Created by ivan on 22.09.2024.
//

import UIKit

class DeviceDetailsViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deviceView: DeviceDetailsView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ data: DeviceJson, _ type: DeviceType) {
        self.deviceView.configure(data, type)
    }
}
