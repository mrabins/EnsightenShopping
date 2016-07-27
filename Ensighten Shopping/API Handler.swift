//
//  API Handler.swift
//  Ensighten Shopping
//
//  Created by Mark Rabins on 7/11/16.
//  Copyright © 2016 Ensighten Inc. All rights reserved.
//

import Foundation

func callAPI() {
    
    let postEndpoint = "http://ensightendemo.com/etc/product-api.json"
    let session = NSURLSession.sharedSession()
    let url = NSURL(string: postEndpoint)!
    
    session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
        guard let realResponse = response as? NSHTTPURLResponse where
            realResponse.statusCode == 200 else {
                print("Not a 200 response")
                return
        }
        // Read the Json
        do {
            if let produceResponse = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                print(produceResponse)
                
                
//                 Parse the Json
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let id = jsonDictionary["id"] as! String
                
                print(id)
                
//                                self.performSelectorOnMainThread("")
                
            }
        } catch {
            print("Something went wrong")
        }
        
    }).resume()
}



