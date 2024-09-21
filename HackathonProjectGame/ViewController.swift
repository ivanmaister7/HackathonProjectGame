//
//  ViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var test: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(resource: .menuBlue)
        // Example usage
        
        let urlString = "https://837a-37-73-14-251.ngrok-free.app/api/device"
        fetchSolarPanelData(from: urlString) { result in
            switch result {
            case .success(let solarPanel):
                self.test.text = "\(solarPanel.name) - \(solarPanel.energyOutput)"
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
        
        
//        let menu = MenuViewController()
//        self.present(menu, animated: true)
    }

    func fetchSolarPanelData(from urlString: String, completion: @escaping (Result<SolarPanel, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let solarPanel = try decoder.decode(SolarPanel.self, from: data)
                completion(.success(solarPanel))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct SolarPanel: Codable {
    let cost: Int
    let energyOutput: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case cost
        case energyOutput = "energy_output"
        case name
    }
}

