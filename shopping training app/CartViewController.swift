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
    var productsCell = ProductsTableViewCell()
    
    
    
    var products = [Product]() {
        didSet {
            updateView()
        }
    }
    
    
    let cellIdentifier = "cartCell"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productsVC.setUpNavBar()
        
        
        setupView()
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let productsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Productmodel")
        
        do {
            
            let fetchedProducts = try managedObjectContext.fetch(productsFetch) as! [Productmodel]
            print("I am fetched:", fetchedProducts)
            
            //call tableViewReload Data here..
            cartTableView.reloadData()

        } catch {
            fatalError("Failed to fetch products: \(error)")
        }
    }

    private func updateView() {
        let hasProducts = products.count > 0
        
        cartTableView.isHidden = !hasProducts
        
        // Hsndle UI Background if not items in the cart
        statusLabel.isHidden = hasProducts
    }
    
    private func setupView() {
        setUpStatusLabel()
        
        updateView()
        
        print("IWAS CALLED  setupView")
    }
    
    private func setUpStatusLabel() {
        statusLabel.text = "You don't have any items in your cart"
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

extension CartViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        productsCell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ProductsTableViewCell
        
        productsCell.productLabel?.text = self.products.description
        productsCell.priceLabel?.text =  "$" + self.products.debugDescription
        
//        productsCell.productImageView.imageFromServerURL(urlString: products.image!, defaultImage: "NoImage")
        
        return productsCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = cartTableView.indexPathForSelectedRow
        let product = products[(indexPath?.row)!]
        
        // ** Handle segue **
        
        performSegue(withIdentifier: "", sender: product)

    }
}

// Handle adding/removal of items in the tableView







