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
    var productName = String()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "prev_menu_btn"), style: .done, target: nil, action: nil)
        
        self.navigationItem.title = productName

       

        
        
        

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
