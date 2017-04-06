//
//  ProductsViewController.swift
//  Shopping Training App
//
//  Created by Eliot Arntz on 4/4/17.
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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        
        productsTableView.delegate = self
        productsTableView.dataSource = self
        
        searchBar.delegate = self
        
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
        
        if isSearchBarActive == true {
            return filteredProducts.count
        } else {
            return products.count
        }
    }
}

extension ProductsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let product = products[(indexPath?.row)!]
        
        performSegue(withIdentifier: "productToDetailsSegue", sender: product)
    }
}

extension ProductsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContextForSearchText(searchBar.text!)
        searchBar.showsCancelButton = false
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        isSearchBarActive = true
        searchBar.showsCancelButton = true
        print("did begin test \(searchBar.text!)")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.showsCancelButton = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.showsCancelButton = true
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
    }
    
    func filterContextForSearchText(_ searchText: String) {
        isSearchBarActive = true
        
        
        let flattenedProducts = products.map { $0 }
        
        filteredProducts = flattenedProducts.filter ({(products) -> Bool in
            print("Products: \(products)" )
            
            let filteredProducts = products.title
            print("I am \(filteredProducts) ")
            
            
            
            
            return (filteredProducts?.contains(searchText))!
        })
        self.productsTableView.reloadData()
    }
}

