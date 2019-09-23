//
//  shopifyPhoto.swift
//  MemoryGameShopify
//
//  Created by Kamal Maged on 2019-09-22.
//  Copyright © 2019 Kamal Maged. All rights reserved.
//

import UIKit

class shopifyPhoto: NSObject {
    var photoURL: URL?
    var photoID: Int = 0
    
    init(photoURL: URL, photoID: Int) {
        
        self.photoID = photoID
        self.photoURL = photoURL
    }

}
