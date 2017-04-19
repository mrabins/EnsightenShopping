//
//  ProductsViewController.swift
//  Shopping Training App
//
//  Created by Mark Rabins on 4/4/17.
//  Copyright © 2017 Ensighten Inc. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var products: [Product] = []
    var productsCell = ProductsTableViewCell()
    var tappedProductName = String()
    var isSearchBarActive = false
    var filteredProducts = [Product]()
    
    let cellIdentifier = "MyCell"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false

        productsTableView.tableHeaderView = searchController.searchBar
        
        self.navigationItem.rightBarButtonItem?.image = UIImage(named:"shoppingbasket")?.withRenderingMode(.alwaysOriginal)
        
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
        if segue.identifier == "productToDetailsSegue" {
            let vc = segue.destination as! ProductDetailsViewController
            let product = sender as! Product
            vc.product = product
            vc.segueString = "productToDetailsSegue"
        }
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
    
    func filterContentForSearchText(_ searchText: String) {
        filteredProducts = products.filter({( product : Product) -> Bool in
            return product.title!.lowercased().contains(searchText.lowercased())
        })
        productsTableView.reloadData()
    }
    
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        productsCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductsTableViewCell
        
        let product: Product

        if searchController.isActive && searchController.searchBar.text != "" {
            product = filteredProducts[indexPath.row]
        } else {
            product = products[indexPath.row]
        }
        
        // Setting Product Title
        if product.title == nil || product.title == "" {
            productsCell.productLabel?.text = "Invalid Product."
        } else {
            productsCell.productLabel?.text = product.title!
        }
        
        // Setting Price Label
        if product.price == nil || product.title == "" {
            productsCell.priceLabel?.text = "$95.00"
        } else {
            productsCell.priceLabel?.text = "$" + product.price!
        }
        productsCell.productImageView.imageFromServerURL(urlString: product.image!, defaultImage: "NoImage")
        
        return productsCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredProducts.count
        }
        return products.count

    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let product = products[(indexPath?.row)!]
        performSegue(withIdentifier: "productToDetailsSegue", sender: product)
    }
}


extension ProductsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension ProductsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

