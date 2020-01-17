//
//  ShopifyPhoto.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2020-01-16.
//  Copyright © 2020 Kamal Maged. All rights reserved.
//

import Foundation

class ShopifyPhoto {
    
    var photoURL: URL?
    var id: Int?
    
    init(id: Int, photoURL: URL) {
        
        self.id = id
        self.photoURL = photoURL
    }
}
