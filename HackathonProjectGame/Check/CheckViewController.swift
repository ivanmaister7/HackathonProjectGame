//
//  CheckViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

struct CheckJson: Codable {
    let id: Int
    let lines: [CheckLineJson]
}

struct CheckLineJson: Codable {
    let id: Int
    let count: Int
    let cost: Double
}

class CheckViewController: UIViewController {
    
    var data: CheckJson = CheckJson(id: 0, lines: [
        CheckLineJson(id: 0, count: 100, cost: 4.32),
        CheckLineJson(id: 0, count: 50, cost: 2.50),
        CheckLineJson(id: 0, count: 32, cost: 5.05)
    ])
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var costLinesStackView: UIStackView!
    
    convenience init(data: CheckJson) {
        self.init()
        self.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkImageView.image = UIImage(resource: .ckeckBg)
        setupView()
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }
    
    private func setupView() {
        
        let stackView = UIStackView(arrangedSubviews: [
            createLabel(text: "⚡️ Електроенергія"),
            createLabel(text: "\(data.lines[0].count) * \(data.lines[0].cost)    \(Double(data.lines[0].count) * data.lines[0].cost) грн")
        ])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0 // Add some spacing between the labels
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView1 = UIStackView(arrangedSubviews: [
            createLabel(text: "💧 Водопостачання"),
            createLabel(text: "\(data.lines[1].count) * \(data.lines[1].cost)    \(Double(data.lines[1].count) * data.lines[1].cost) грн")
        ])
        stackView1.axis = .horizontal
        stackView1.alignment = .fill
        stackView1.distribution = .fillEqually
        stackView1.spacing = 0 // Add some spacing between the labels
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView2 = UIStackView(arrangedSubviews: [
            createLabel(text: "🔥 Теплопостачання"),
            createLabel(text: "\(data.lines[2].count) * \(data.lines[2].cost)    \(Double(data.lines[2].count) * data.lines[2].cost) грн")
        ])
        stackView2.axis = .horizontal
        stackView2.alignment = .fill
        stackView2.distribution = .fillEqually
        stackView2.spacing = 0 // Add some spacing between the labels
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let finalSum = Double(data.lines[0].count) * data.lines[0].cost
        + Double(data.lines[1].count) * data.lines[1].cost
        + Double(data.lines[2].count) * data.lines[2].cost
        
        let stackView3 = UIStackView(arrangedSubviews: [
            createLabel(text: ""),
            createLabel(text: ""),
            createLabel(text: String(format: "%.2f", finalSum) + " грн")
        ])
        stackView3.axis = .horizontal
        stackView3.alignment = .fill
        stackView3.distribution = .fillEqually
        stackView3.spacing = 0 // Add some spacing between the labels
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        
        self.costLinesStackView.addArrangedSubview(stackView)
        self.costLinesStackView.addArrangedSubview(stackView1)
        self.costLinesStackView.addArrangedSubview(stackView2)
        self.costLinesStackView.addArrangedSubview(stackView3)
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
