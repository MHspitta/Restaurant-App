//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Michael Hu on 07-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import UIKit


// MARK: - Classes
class CategoryTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    var categories = [String]()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the interface of viewcontroller if it contains data
        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }
    
    // Count categories
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return categories.count
    }
    
    // Fill the tables
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    // Action segue to go to the menutableviewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }
    
    // MARK: - Functions
    
    // Function to update categories
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    // function to configure categories
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
}
