//
//  StartGameViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-10-02.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func isPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            performSegue(withIdentifier: "easyGame", sender: sender)
            break
        case 2:
            performSegue(withIdentifier: "normalGame", sender: sender)
            break
        case 3:
            performSegue(withIdentifier: "hardGame", sender: sender)
            break
        case 4:
            performSegue(withIdentifier: "veryHard", sender: sender)
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ViewController
        switch segue.identifier {
        case "easyGame":
            viewController.gameArraySize = 20
            viewController.itemsPerRow = 5.0
            viewController.numberOfRows = 8.0
            break
        case "normalGame":
            viewController.gameArraySize = 30
            viewController.itemsPerRow = 6.0
            viewController.numberOfRows = 10.0
            break
        case "hardGame":
            viewController.gameArraySize = 40
            viewController.itemsPerRow = 8.0
            viewController.numberOfRows = 10.0
            break
        case "veryHard":
            viewController.gameArraySize = 50
            viewController.itemsPerRow = 10.0
            viewController.numberOfRows = 10.0
            break
        default:
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
