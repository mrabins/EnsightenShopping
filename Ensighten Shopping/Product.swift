//
//  Product.swift
//  Ensighten Shopping
//
//  Created by Eliot Arntz on 8/24/16.
//  Copyright © 2016 Ensighten Inc. All rights reserved.
//

import Foundation

struct Product {
    var id: String?
    var title: String?
    var content: String?
    var salePrice: String?
    var regularPrice: String?
    var price: String?
    var image: String?
    
    init(id: String, title: String, content: String, salePrice: String, regularPrice: String, price: String, image: String) {
        
        self.id = id
        self.title = title
        self.content = content
        self.salePrice = salePrice
        self.regularPrice = regularPrice
        self.price = price
        self.image = image
    }
}