//
//  API Handler.swift
//  Ensighten Shopping
//
//  Created by Mark Rabins on 7/11/16.
//  Copyright © 2016 Ensighten Inc. All rights reserved.
//

import Foundation

class APIHandler {
   class func callAPI(_ success: @escaping (_ products: [Product]) -> (), error errorCallback: @escaping (_ errorMessage: String) -> ()) {
        
        let postEndpoint = "http://ensightendemo.com/etc/product-api.json"
        let session = URLSession.shared
        let url = URL(string: postEndpoint)!
        let request = URLRequest(url: url)


        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                print("THIS ONE IS PRINTED, TOO")
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    //taskCallback(true, json as AnyObject?)
                    
                    do {
                        if NSString(data:data, encoding: String.Encoding.utf8.rawValue) != nil {
                            
                            //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                            
                            // Parse the Json
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                            
                            guard let products = jsonDictionary["products"] as? NSArray else {
                                
                                return }
                            
                            var result: [Product] = []
                            
                            for product in products {
                                
                                guard let validProduct = product as? NSDictionary, let id = validProduct["id"] as? String,let title = validProduct["title"] as? String, let content = validProduct["content"] as? String,let salePrice = validProduct["sale_price"] as? String,let regularPrice = validProduct["regular_price"] as? String,let price = validProduct["price"] as? String,let image = validProduct["image"] as? String else { return }
                                result.append(Product(id: id, title: title, content: content, salePrice: salePrice, regularPrice: regularPrice, price: price, image: image))
                            }
                            success(result)
                        } else {
                            errorCallback("No Valid Information")
                        }
                    } catch {
                        print("Data was not properly formatted")
                    }

                    
                } else {
                    //taskCallback(false, json as AnyObject?)
                    print("Not a 200 response")
                    errorCallback(error as! String)
                    return
                }
            }
        })
        task.resume()
    }
}



func callAPI(_ success: @escaping (_ products: [Product]) -> (), error errorCallback: @escaping (_ errorMessage: String) -> ()) {
    
    let postEndpoint = "http://ensightendemo.com/etc/product-api.json"
    let session = URLSession.shared
    let url = URL(string: postEndpoint)!
    
    session.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse?, error: NSError?) -> Void in
        
        guard let realResponse = response as? HTTPURLResponse,
            realResponse.statusCode == 200 else {
                print("Not a 200 response")
                errorCallback(error!.description)
                return
        }
        
        // Read the Json
        do {
            if NSString(data:data!, encoding: String.Encoding.utf8.rawValue) != nil {
                
                // Parse the Json
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                guard let products = jsonDictionary["products"] as? NSArray else {
                    
                    return }
                
                var result: [Product] = []
                
                for product in products {
                    
                    guard let validProduct = product as? NSDictionary, let id = validProduct["id"] as? String,let title = validProduct["title"] as? String, let content = validProduct["content"] as? String,let salePrice = validProduct["sale_price"] as? String,let regularPrice = validProduct["regular_price"] as? String,let price = validProduct["price"] as? String,let image = validProduct["image"] as? String else { return }
                    result.append(Product(id: id, title: title, content: content, salePrice: salePrice, regularPrice: regularPrice, price: price, image: image))
                }
                success(result)
            } else {
                errorCallback("No Valid Information")
            }
        } catch {
            print("Data was not properly formatted")
        }
    } as! (Data?, URLResponse?, Error?) -> Void).resume()
}

