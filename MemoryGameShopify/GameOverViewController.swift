//
//  GameOverViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-10-02.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {


    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var minText: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    var time = 0
    var playerTurn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerLabel.text = playerTurn ? "P2 Won!" : "P1 Won!"
        
        if time < 60 {
            minLabel.removeFromSuperview()
            minText.removeFromSuperview()
        }
        let minutes = time / 60
        let seconds = time - minutes * 60
        minLabel.text = "\(minutes)"
        secLabel.text = "\(seconds)"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func isPressed(_ sender: UIButton) {
        if let startGameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewGame") as? StartGameViewController
        {
            present(startGameViewController, animated: true, completion: nil)
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
