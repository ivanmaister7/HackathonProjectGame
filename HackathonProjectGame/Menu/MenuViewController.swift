//
//  MenuViewController.swift
//  HackathonProjectGame
//
//  Created by ivan on 21.09.2024.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let cellId = String(describing: MenuCell.self)
    private let apiLink = "https://e402-37-73-14-251.ngrok-free.app"
    private let apiDevice = "/api/levels"
    private var menuList: [MenuJson] = []
    private let levelViewControllers: [UIViewController] = [
        Level1ViewController()
    ]
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(resource: .menuBlue)
        
        self.helloLabel.font = .systemFont(ofSize: 42)
        self.helloLabel.textColor = .white
        self.helloLabel.text = "Hello, Ivan!"
        
        self.menuCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        self.menuCollectionView.backgroundColor = .clear
        
        fillMenu()
    }
    
    fileprivate func fillMenu() {
        Task {
            do {
                self.menuList = try await fetchMenuData()
                self.menuCollectionView.reloadData()
            } catch {
                self.menuList = [
                    MenuJson(id: 0, name: "Room", level: 1, isAvailable: true),
                    MenuJson(id: 0, name: "House", level: 2, isAvailable: false),
                    MenuJson(id: 0, name: "OSBB", level: 3, isAvailable: false),
                    MenuJson(id: 0, name: "District", level: 4, isAvailable: false),
                    MenuJson(id: 0, name: "Ciry", level: 5, isAvailable: false),
                    MenuJson(id: 0, name: "Country", level: 6, isAvailable: false),
                ]
                self.menuCollectionView.reloadData()
                print("Failed to fetch or parse data: \(error)")
            }
        }
    }
    
    func fetchMenuData() async throws -> [MenuJson] {
        try await fetch(from: apiLink + apiDevice)
    }
    
    func fetch<S: Codable>(from urlString: String) async throws -> S {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Make the network request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check for a successful response (status code 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decode the JSON data into the Swift struct
        let energyOutput = try JSONDecoder().decode(S.self, from: data)
        return energyOutput
    }
}

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let cellModel = menuList[indexPath.row]
        
        cell.configureCell(model: cellModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if collectionView == contentCollection {
//            let cellModel = model[indexPath.row]
//            didSelectStaffItem(cellModel: cellModel)
//        } else if collectionView == filterButtonsCollection {
//            if isLocked && indexPath.row == 0 {
//                IAPStaffManager.shared.openStaffSub(style: .unlockContentProduct,
//                                                    onViewController: self,
//                                                    callback: {[weak self] in
//                    guard let self else { return }
//                    self.isLocked = !IAPStaffManager.shared.productBought.contains(.unlockContentProduct) && StaffConfigurations.subscriptionEnable
//                    self.activeCategoriesNames = self.categories[indexPath.row]
//                    self.filterModel()
//                    self.filterButtonsCollection.reloadData()
//                })
//            } else {
//                activeCategoriesNames = categories[indexPath.row]
//                filterModel()
//                filterButtonsCollection.reloadData()
//            }
//        }
        
        self.navigationController?.pushViewController(levelViewControllers[indexPath.row], animated: true)
        
//        print("\(menuList[indexPath.row].name)")
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (menuCollectionView.frame.width - 16) / 2
        return CGSize(width: size, height: size)
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

// Define the structure to parse the response
struct MenuJson: Codable {
    let id: Int
    let name: String
    let level: Int
    let isAvailable: Bool
    
    // Coding keys to match JSON keys with Swift properties
    enum CodingKeys: String, CodingKey {
        case id, name, level
        case isAvailable = "is_available"
    }
}
