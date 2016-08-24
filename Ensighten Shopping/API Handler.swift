//
//  API Handler.swift
//  Ensighten Shopping
//
//  Created by Mark Rabins on 7/11/16.
//  Copyright © 2016 Ensighten Inc. All rights reserved.
//

import Foundation

func callAPI(success: (products: [Product]) -> (), error errorCallback: (errorMessage: String) -> ()) {
    
    let postEndpoint = "http://ensightendemo.com/etc/product-api.json"
    let session = NSURLSession.sharedSession()
    let url = NSURL(string: postEndpoint)!
    
    session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        
        guard let realResponse = response as? NSHTTPURLResponse where
            realResponse.statusCode == 200 else {
                print("Not a 200 response")
                errorCallback(errorMessage: error!.description)
                return
        }
        
        // Read the Json
        do {
            if NSString(data:data!, encoding: NSUTF8StringEncoding) != nil {
                
                // Parse the Json
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                guard let products = jsonDictionary["products"] as? NSArray else {
                    
                    return }
                
                var result: [Product] = []
                
                for product in products {
                    
                    guard let validProduct = product as? NSDictionary, id = validProduct["id"] as? String,title = validProduct["title"] as? String, content = validProduct["content"] as? String,salePrice = validProduct["sale_price"] as? String,regularPrice = validProduct["regular_price"] as? String,price = validProduct["price"] as? String,image = validProduct["image"] as? String else { return }
                    result.append(Product(id: id, title: title, content: content, salePrice: salePrice, regularPrice: regularPrice, price: price, image: image))
                }
                success(products: result)
            } else {
                errorCallback(errorMessage: "No Valid Information")
            }
        } catch {
            print("Data was not properly formatted")
        }
    }).resume()
}

