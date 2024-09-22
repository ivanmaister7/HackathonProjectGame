//
//  MiniGameViewViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 22.09.2024.
//

import UIKit

class MiniGameViewViewController: UIViewController {

    @IBOutlet weak var miniGameBg: UIImageView!
    @IBOutlet weak var miniGame: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        miniGame.image = UIImage(resource: .miniGame)
        miniGameBg.image = UIImage(resource: .miniGameBg)
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
