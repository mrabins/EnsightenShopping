//
//  ProductDetailsViewController.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var checkOutButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let yellowColor = UIColor(red: 255.0/255.0, green: 180.0/255.0, blue: 0/255.0, alpha: 0.5)
    
    var segueString = String()
    
    var product:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "prev_menu_btn"), style: .done, target: nil, action: nil)
        self.navigationItem.title = product.title
        productImage.image = UIImage(named: product.image!)
        
        if let productPriceText = product.price {
            productPrice.text = "$ " + productPriceText
        } else {
            productPrice.text = "$95.00"
        }
        productDescription.text = removeHTMLFromString(text: product.content!)
        productImage.imageFromServerURL(urlString: product.image!, defaultImage: "NoImage")
        productImage.layer.cornerRadius = 3.0
        productImage.layer.shadowOpacity = 2.5
        productImage.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        productImage.layer.shadowColor = yellowColor.cgColor

    }
    
    func setupUI() {
        
        checkOutButton.backgroundColor = yellowColor.withAlphaComponent(1.0)
        checkOutButton.layer.shadowOpacity = 2
        checkOutButton.layer.shadowOffset = CGSize(width: 0.50, height: 1.0)
        checkOutButton.layer.shadowColor = UIColor.black.cgColor

        if segueString == "productToDetailsSegue" {
            checkOutButton.setTitle("Add To Cart", for: .normal)
        } else {
            checkOutButton.setTitle("Check Out", for: .normal)
        }
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
    
// Mark: IBActions
    
    @IBAction func titleButtonPressed(_ sender: UIButton) {
        //right now button will only add items to cart if the segue is the proper name
        if segueString == "productToDetailsSegue" {
            
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            
            let productModel = NSEntityDescription.insertNewObject(forEntityName: "Productmodel", into: managedObjectContext) as! Productmodel
            
            productModel.id = product.id
            productModel.title = product.title
            productModel.content = product.content
            productModel.salePrice = product.salePrice
            productModel.regularPrice = product.regularPrice
            productModel.price = product.price
            productModel.image = product.image
            
            print(productModel)
            
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
    }
    
    
    
}
