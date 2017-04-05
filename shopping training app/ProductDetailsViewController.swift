//
//  ProductDetailsViewController.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("product: + \(product)")
        
        view.backgroundColor = UIColor.blue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
