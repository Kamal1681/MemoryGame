//
//  GameOverViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-10-02.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {


    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bestTimeLabel: UILabel!
    
    var time = 0
    var bestTimeEasy = 0
    var bestTimeNormal = 0
    var bestTimeHard = 0
    var bestTimeVeryHard = 0
    var gameArraySize = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkBestTime()
        updateTimeLabel()
    }
    
    func checkBestTime() {
        switch gameArraySize {
            
        case 10:
            bestTimeEasy = UserDefaults.standard.integer(forKey: "bestTimeEasy")
            if bestTimeEasy == 0 {
                bestTimeEasy = time
            } else {
                bestTimeEasy = min(time, bestTimeEasy)
            }
            UserDefaults.standard.set(bestTimeEasy, forKey: "bestTimeEasy")
            UserDefaults.standard.synchronize()
            updateBestTimeLabel(time: bestTimeEasy)
            
        case 20:
            bestTimeNormal = UserDefaults.standard.integer(forKey: "bestTimeNormal")
            if bestTimeNormal == 0 {
                bestTimeNormal = time
            } else {
                bestTimeNormal = min(time, bestTimeNormal)
            }
            UserDefaults.standard.set(bestTimeNormal, forKey: "bestTimeNormal")
            UserDefaults.standard.synchronize()
            updateBestTimeLabel(time: bestTimeNormal)
            
        case 30:
            bestTimeHard = UserDefaults.standard.integer(forKey: "bestTimeHard")
            if bestTimeHard == 0 {
                bestTimeHard = time
            } else {
                bestTimeHard = min(time, bestTimeHard)
            }
            UserDefaults.standard.set(bestTimeHard, forKey: "bestTimeHard")
            UserDefaults.standard.synchronize()
            updateBestTimeLabel(time: bestTimeHard)
            
        case 50:
            bestTimeVeryHard = UserDefaults.standard.integer(forKey: "bestTimeVeryHard")
            if bestTimeVeryHard == 0 {
                bestTimeVeryHard = time
            } else {
                bestTimeVeryHard = min(time, bestTimeVeryHard)
            }
            UserDefaults.standard.set(bestTimeVeryHard, forKey: "bestTimeVeryHard")
            UserDefaults.standard.synchronize()
            updateBestTimeLabel(time: bestTimeVeryHard)
            
        default:
            break
        }
    }
    
    
    func updateTimeLabel() {
        
         let minutes = time / 60
         let seconds = time - minutes * 60
         
         if time < 60 {
             timeLabel.text = "Congrats in: \(seconds) sec"
         } else {
             timeLabel.text = "Finished in: \(minutes) min and \(seconds) sec"
         }
    }
    
    func updateBestTimeLabel(time: Int) {
        let minutes = time / 60
        let seconds = time - minutes * 60
        
        if time < 60 {
            bestTimeLabel.text = "Best Time: \(seconds) sec"
        } else {
            bestTimeLabel.text = "Best Time: \(minutes) min and \(seconds) sec"
        }
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
