//
//  ViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-09-19.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, GameModelDelegate {
    
    var gameModel: GameModel?
    let reuseIdentifier = "ShopifyPhotoCell"
    var photoArray = [ShopifyPhoto]()
    var gameDictionary = [Int: ShopifyPhoto]()
    var gameArray = [ShopifyPhoto]()
    
    var score = 0
    var time = 0
    var timer = Timer()
    var winner = false

    var gameArraySize: Int = 50
    var itemsPerRow: CGFloat = 10.0
    var numberOfRows: CGFloat = 10.0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var shopifyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrievePhotos()
        gameModel = GameModel()
        gameModel?.delegate = self
        updateLabels()
        shopifyCollectionView.delegate = self
        shopifyCollectionView.dataSource = self
        
        startTimer()
        

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        shopifyCollectionView.reloadData()
    }
    
// MARK: - Updating game HUD
    
    func updateLabels() {
        scoreLabel.text = "Score: \(gameModel!.score)"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            self.time += 1
            self.timeLabel.text = "Time: \(self.time)"
        })
    }

     func checkWinStatus(score: Int) {

        if score == gameArraySize {
            gameModel?.disableCollectionView = true
            
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline:.now() + .seconds(3), execute: {
                self.gameOver()
            })
            
        }
    }
    
    func gameOver() {
        
        DispatchQueue.main.async {
            self.gameModel!.playSound(fileName: "gameOver")
        }
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameOver") as? GameOverViewController
        {
            viewController.gameArraySize = gameArraySize
            viewController.time = self.time
            present(viewController, animated: true, completion: nil)
        }
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Setting up the photos array
    
    func retrievePhotos() {
        
       let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            do {
                if data != nil {
                    let products = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String : [Dictionary<String, Any>]]
                    
                    for product in (products["products"]!) {
                        let id = product["id"] as! Int
                        let image = product["image"] as! Dictionary<String, Any>
                        let photoURL = URL(string: (image["src"] as! String))
                        
                        let shopifyPhoto = ShopifyPhoto(id: id, photoURL: photoURL! )
                        self.photoArray.append(shopifyPhoto)
                        self.photoArray.append(shopifyPhoto)
                    }
                    self.constructGameArray()
                    DispatchQueue.main.async {
                        self.shopifyCollectionView.reloadData()
                    }
                }
            }
            catch {
                print("Error")
            }
        }.resume()
    }
    
    func constructGameArray() {
        
        while gameDictionary.count < gameArraySize {
            guard  let randomPhoto = photoArray.randomElement() else {return}
           
            let key : Int = randomPhoto.id!
            gameDictionary[key] = randomPhoto
        }
        for shopifyPhoto in gameDictionary.values {
            gameArray.append(shopifyPhoto)
            gameArray.append(shopifyPhoto)
        }
        gameArray.shuffle()
    }
}
// MARK: - CollectionView Datasource and delegate methods

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? ShopifyPhotoCell else {
                preconditionFailure("Invalid cell type")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if gameModel!.disableCollectionView {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! ShopifyPhotoCell

        let url = gameArray[indexPath.row].photoURL!
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
                if data != nil {

                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.shopifyPhoto.image = image
                        self.gameModel?.gameLogic(cell: cell, shopifyPhoto: self.gameArray[indexPath.row])
                    }
                }
        }.resume()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        guard let collection = shopifyCollectionView else {
            return CGSize(width: 0, height: 0)
        }
        if UIDevice.current.orientation.isLandscape {
            let width = collection.frame.size.width / numberOfRows
            let height = collection.frame.size.height / itemsPerRow
            return CGSize(width: width, height: height)
        }
        else {
            let width = collection.frame.size.width / itemsPerRow
            let height = collection.frame.size.height / numberOfRows
            return CGSize(width: width, height: height)
        }
        
        }
    
}
