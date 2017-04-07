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
    
    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "prev_menu_btn"), style: .done, target: nil, action: nil)
        
        self.navigationItem.title = product.title
        
        productImage.image = UIImage(named: product.image!)
        
        
        if let productPriceText = product.price {
            productPrice.text = "$ " + productPriceText
        } else {
             productPrice.text = "$95.00"
        }
        
        
        
        productDescription.text = removeStringFromText(text: product.content!)
            
        
        
        
        print("produict context \(product.content)")
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func removeStringFromText(text: String) -> String {
        let okayCharacters: Set <Character> = Set("<strong> </strong>".characters)
        return String(text.characters.filter {okayCharacters.contains($0)})
        
    }
    
    
    
    
}
