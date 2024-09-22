//
//  DeviceDetailsView.swift
//  HackathonProjectGame
//
//  Created by ivan on 22.09.2024.
//

import UIKit

class DeviceDetailsView: UIView {
    
    // Subviews
    private let imageView = UIImageView()
    private let infoStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    func configure(_ data: DeviceJson, _ type: DeviceType) {
        infoStackView.removeAllArrangedSubviews()
        // Add labels or rows to infoStackView (as an example)
        let label1 = UILabel()
        label1.text = "\(data.name)"
        label1.numberOfLines = 0
        label1.textColor = .white
        label1.textAlignment = .center
        
        let label2 = UILabel()
        label2.text = "\(data.powerConsumption)Bт/год"
        label1.numberOfLines = 0
        label2.textColor = .white
        label2.textAlignment = .center
        
        let label3 = UILabel()
        label3.text = "\(data.price)$"
        label1.numberOfLines = 0
        label3.textColor = .white
        label3.textAlignment = .center
        
        infoStackView.addArrangedSubview(label1)
        infoStackView.addArrangedSubview(label2)
        infoStackView.addArrangedSubview(label3)
        
        imageView.image = UIImage(named: "\(data.name)")
    }
    
    private func setupView() {
        // Set background color and border
        self.backgroundColor = .menuBlue
        self.layer.borderColor = UIColor(resource: .infoBorder).cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        // Add shadow
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        
        // Setup imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage()//UIImage(systemName: "photo") // Placeholder image
        
        // Setup infoStackView for detail rows
        infoStackView.axis = .vertical
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 4
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // Add subviews to the main view
        self.addSubview(imageView)
        self.addSubview(infoStackView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // ImageView (taking 60% of height)
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            
            // InfoStackView (taking remaining 40% of height)
            infoStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
