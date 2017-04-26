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
    let products = [Product]()
    
    
    let cellIdentifier = "cartCell"
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    private let persistentContainer = NSPersistentContainer(name: "ShoppingTrainingApp")
    
    fileprivate lazy var fetchResultsController: NSFetchedResultsController <Productmodel> = {
        
        // Create fetch request
        let fetchRequest: NSFetchRequest<Productmodel> = Productmodel.fetchRequest()
        
        // Configure request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        // Create Fetch Request
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure fetched results controller
        fetchResultsController.delegate = self
        
        return fetchResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsVC.setUpNavBar()
        setupView()
        
        cartTableView.dataSource = self
        cartTableView.delegate = self
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Load Persistent Store")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                self.updateView()
            }
        }
    }
    
    private func updateView() {
        var hasProducts = false
        if let product = fetchResultsController.fetchedObjects {
            print("proucts are \(product)")
            
            hasProducts = product.count > 0
            self.cartTableView.reloadData()
            
        }
        cartTableView.isHidden = !hasProducts
        
        
        // Hsndle UI Background if not items in the cart
        statusLabel.isHidden = hasProducts
        
        
    }
    
    private func setupView() {
        self.navigationItem.title = "Cart"
        setUpStatusLabel()
        updateView()
        
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
        
        productsCell = cartTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
        
        let product = fetchResultsController.object(at: indexPath)
        
        print("cellForRowAt cellForRowAt cellForRowAt \(product)")

        
        productsCell.productLabel?.text = product.title!
        
        productsCell.priceLabel?.text =  "$" + product.price!
        productsCell.productImageView.imageFromServerURL(urlString: product.image!, defaultImage: "NoImage")
                
        return productsCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let product = fetchResultsController.fetchedObjects else { return 0 }
        return product.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//                let indexPath = cartTableView.indexPathForSelectedRow
//        
//                let product = products[(indexPath?.row)!]
        
        // ** Handle segue **
        
        //        performSegue(withIdentifier: "", sender: product)
        
    }
}


// Handle adding/removal of items in the tableView


    




extension CartViewController: NSFetchedResultsControllerDelegate {}




