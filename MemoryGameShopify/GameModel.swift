//
//  GameModel.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2020-01-11.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol GameModelDelegate {
    func checkWinStatus(score: Int)
    func updateLabels()
}

class GameModel {
    
    var delegate: GameModelDelegate?
    var audioEffect: AVAudioPlayer?
    var selectCounter = 0
    
    var firstCell: ShopifyPhotoCell?
    var secondCell: ShopifyPhotoCell?
    var firstPhoto: ShopifyPhoto?
    var secondPhoto: ShopifyPhoto?
    var p1Score = 0
    var p2Score = 0
    
    var disableCollectionView = false
    var playerTurnToggle = false
    
    func gameLogic(cell: ShopifyPhotoCell, shopifyPhoto: ShopifyPhoto) {
        selectCounter += 1
        if selectCounter == 1 {
            firstCell = cell
            firstPhoto = shopifyPhoto
            
        }
        else if selectCounter == 2 {
            
            secondCell = cell
            secondPhoto = shopifyPhoto
            if firstPhoto?.id == secondPhoto?.id && firstCell != secondCell {
                if playerTurnToggle {
                    p2Score += 1
                    delegate?.checkWinStatus(score: p2Score)
                } else {
                    p1Score += 1
                    delegate?.checkWinStatus(score: p1Score)
                }

                DispatchQueue.main.async {
                    self.playSound(fileName: "correctMatch")
                }
                
                firstCell?.isUserInteractionEnabled = false
                secondCell?.isUserInteractionEnabled = false
            } else if firstPhoto?.id != secondPhoto?.id {
                disableCollectionView = true
                DispatchQueue.main.async {
                    self.playSound(fileName: "fail")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

                    self.firstCell!.shopifyPhoto?.image = UIImage(named: "images")
                    self.secondCell!.shopifyPhoto?.image = UIImage(named: "images")
                    self.disableCollectionView = false
                })
            }
            playerTurnToggle = !playerTurnToggle
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.delegate?.updateLabels()
            }
        
            selectCounter = 0
        }

    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")!
              
              do {
                  audioEffect = try AVAudioPlayer.init(contentsOf: url)
                  guard let audioEffect = audioEffect else {
                      return
                  }
                  audioEffect.prepareToPlay()
                  audioEffect.play()
        
              }
              catch let error {
                  print(error)
              }
    }
    

}
