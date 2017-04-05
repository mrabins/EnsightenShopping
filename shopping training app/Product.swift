//
//  Product.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
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
