//
//  ViewController.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-09-19.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var photoArray = [ShopifyPhoto]()
    var gameDictionary = [Int: ShopifyPhoto]()
    var gameArray = [ShopifyPhoto]()
    
    @IBOutlet weak var shopifyCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        shopifyCollectionView.delegate = self
        shopifyCollectionView.dataSource = self
        shopifyCollectionView.register(ShopifyPhotoCell.self, forCellWithReuseIdentifier: "shopifyPhotoCell")
        retrievePhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "shopifyPhotoCell",
            for: indexPath) as? ShopifyPhotoCell else {
                preconditionFailure("Invalid cell type")
        }
        cell.shopifyPhoto.image = UIImage.init(named: "images")
        return cell
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
                    
                }
            }
            catch {
                print("Error")
            }
        }
        task.resume()
        
        
    }
    
    func constructGameArray() {
        
        for _ in 1 ... 10 {
            guard  let randomPhoto = photoArray.randomElement() else {return}
           
            let key : Int = randomPhoto.id!
            gameDictionary[key] = randomPhoto
            gameArray.append(randomPhoto)
            gameArray.append(randomPhoto)
        }
        gameArray.shuffle()
    }
   

}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}
