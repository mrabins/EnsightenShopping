//
//  ProductsViewController.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    
    
    var products: [Product] = []
    var productsCell = ProductsTableViewCell()
    let cellIdentifier = "MyCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self

        
        APIHandler.callAPI({ products in
            self.products = products
            
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }) { (errorMessage) in print(errorMessage)}

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = productsTableView.indexPathForSelectedRow
        //print(selectedIndexPath)
        let selectedProduct = products[(selectedIndexPath?.row)!]
        let destinationVC = segue.destination
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpNavBar() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let imageLogo = UIImage(named: "Hosoren Logo")
        imageView.image = imageLogo
        
        navigationItem.titleView = imageView
        
    }
}

extension ProductsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        productsCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
        
        let product = self.products[indexPath.row]
        
        // Setting Product Title
        
        if product.title == nil || product.title == "" {
            productsCell.productLabel?.text = "Invalid Product."
        } else {
            productsCell.productLabel?.text = product.title!
        }
        
        
        // Setting Price Label
        
        if product.price == nil || product.title == "" {
            productsCell.priceLabel?.text = "$ 95.00"
        } else {
            productsCell.priceLabel?.text = "$ " + product.price!
        }
        
        
        
        
        
        productsCell.productImageView.imageFromServerURL(urlString: product.image!, defaultImage: "NoImage")
        
        return productsCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}

extension ProductsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        
        
        
        let selectedProduct = tableView.cellForRow(at: indexPath!) as 
        
    }
}



