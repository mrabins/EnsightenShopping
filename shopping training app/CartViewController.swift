//
//  CartViewController.swift
//  Shopping Training App
//
//  Created by Mark Rabins on 4/7/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    var productsVC = ProductsViewController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsVC.setUpNavBar()
        
        print("I was called")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
