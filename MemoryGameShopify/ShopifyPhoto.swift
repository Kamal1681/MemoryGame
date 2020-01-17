//
//  shopifyPhoto.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-09-22.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class ShopifyPhoto {
    var photoURL: URL?
    var id: Int?
    
    init(id: Int, photoURL: URL) {
        
        self.id = id
        self.photoURL = photoURL
    }

}
