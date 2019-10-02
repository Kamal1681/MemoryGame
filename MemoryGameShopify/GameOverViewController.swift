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
    var time = 0
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
