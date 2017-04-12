//
//  CartViewController.swift
//  Shopping Training App
//
//  Created by Mark Rabins on 4/7/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController {
    
    var productsVC = ProductsViewController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsVC.setUpNavBar()
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let productsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Productmodel")
        
        do {
            let fetchedProducts = try managedObjectContext.fetch(productsFetch) as! [Productmodel]
            print(fetchedProducts)
            //call tableViewReload Data here..

        } catch {
            fatalError("Failed to fetch products: \(error)")
        }
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
