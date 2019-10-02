//
//  ViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-09-19.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let reuseIdentifier = "ShopifyPhotoCell"
//    let sectionInsets = UIEdgeInsets(top: 50.0,
//                                     left: 20.0,
//                                     bottom: 50.0,
//                                     right: 20.0)
    var photoArray = [ShopifyPhoto]()
    var gameDictionary = [Int: ShopifyPhoto]()
    var gameArray = [ShopifyPhoto]()
    var selectCounter = 0
    var score = 0
    var firstCell: ShopifyPhotoCell?
    var secondCell: ShopifyPhotoCell?
    var firstPhoto: ShopifyPhoto?
    var secondPhoto: ShopifyPhoto?
    var disableCollectionView = false
    
    @IBOutlet weak var shopifyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retrievePhotos()
        shopifyCollectionView.delegate = self
        shopifyCollectionView.dataSource = self

        
    }
    
 
    
    func retrievePhotos() {
       let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            do {
                if data != nil {
                    let products = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! [String : Array<Dictionary<String, Any>>]
                    
                    for product in (products["products"]!) {
                        let id = product["id"] as! Int
                        let image = product["image"] as! NSDictionary
                        let photpoURL = URL(string: (image["src"] as! String))
                        
                        let shopifyPhoto = ShopifyPhoto(id: id, photoURL: photpoURL! )
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
        }
        task.resume()
        
        
    }
    
    func constructGameArray() {
        
        while gameDictionary.count < 10 {
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
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArray.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as? ShopifyPhotoCell else {
                preconditionFailure("Invalid cell type")
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if disableCollectionView {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! ShopifyPhotoCell
    
        let url = gameArray[indexPath.row].photoURL!
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
                if data != nil {

                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        cell.shopifyPhoto.image = image
                        self.gameLogic(cell: cell, shopifyPhoto: self.gameArray[indexPath.row])
                    }
                }
        
        }
        task.resume()
 

        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 80.0, height: 80.0)
    }
    func gameLogic(cell: ShopifyPhotoCell, shopifyPhoto: ShopifyPhoto) {
        selectCounter += 1

        if selectCounter == 1 {
            firstCell = cell
            firstPhoto = shopifyPhoto
            
        }
        else if selectCounter == 2 {
            secondCell = cell
            secondPhoto = shopifyPhoto
            if firstPhoto?.id == secondPhoto?.id {
                score += 1
                
            } else {
                disableCollectionView = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    self.firstCell!.shopifyPhoto?.image = UIImage(named: "images")
                    self.secondCell!.shopifyPhoto?.image = UIImage(named: "images")
                    self.disableCollectionView = false
                })
                
            }
          selectCounter = 0
        }

    }
}
