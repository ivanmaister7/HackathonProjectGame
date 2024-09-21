//
//  Level1ViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

class Level1ViewController: UIViewController {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lvl1Bg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lvl1Bg.image = UIImage(resource: .level1Bg)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkButtonAction(_ sender: Any) {
        //open check window
    }
}
