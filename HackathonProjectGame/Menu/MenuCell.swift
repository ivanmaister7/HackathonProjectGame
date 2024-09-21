//
//  MenuCell.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

class MenuCell: UICollectionViewCell {
    let images = [
        "house",
        "window.awning",
        "house.lodge",
        "mappin.and.ellipse",
        "mappin.and.ellipse.circle",
        "map",
        "map.circle",
        "questionmark.circle.dashed",
    ]
    
    @IBOutlet weak var menuCellIcon: UIImageView!
    @IBOutlet weak var menuCellNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: MenuJson) {
        self.menuCellNameLabel.text = model.name
        self.menuCellNameLabel.textColor = .white
        self.menuCellIcon.image = getImageFromName(model.level - 1)
        self.backgroundColor = model.isAvailable ? .clear : .black.withAlphaComponent(0.5)
    }
    
    private func getImageFromName(_ level: Int) -> UIImage? {
        if level >= images.count { return nil }
        
        return UIImage(systemName: images[level])
    }
}
