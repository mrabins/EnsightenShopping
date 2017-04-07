//
//  ProductDetailsViewController.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var checkOutButton: UIButton!
    
    var segueString = String()
    
    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonTitle()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "prev_menu_btn"), style: .done, target: nil, action: nil)
        self.navigationItem.title = product.title
        productImage.image = UIImage(named: product.image!)
        
        if let productPriceText = product.price {
            productPrice.text = "$ " + productPriceText
        } else {
            productPrice.text = "$95.00"
        }
        productDescription.text = removeHTMLFromString(text: product.content!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeHTMLFromString(text: String) -> String {
        let summary = product.content
        let str = summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return str!
    }
    
    func buttonTitle() {
        if segueString == "productToDetailsSegue" {
            checkOutButton.setTitle("Add To Cart", for: .normal)
        } else {
            checkOutButton.setTitle("Check Out", for: .normal)
        }
        
    }
}
