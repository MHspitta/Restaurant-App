//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Michael Hu on 07-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    //MARK: - Variables
    
    var delegate: AddToOrderDelegate?
    var menuItem: MenuItem!
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    // MARK: - Overrides
    
    // View Function
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
    }
    
    // MARK: - Functions
    
    // Function to setup delegate
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
            let orderTableViewController = navController.viewControllers.first as? OrderTableViewController {
            delegate = orderTableViewController
        }
    }
    
    // Update function to update all labels and descriptions
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
        
        // Fetch and  load the image
        MenuController.shared.fetchImage(url: menuItem.imageURL) {
            (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    //MARK: - Actions
    
    // Action func for animation when button is tapped
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
}


