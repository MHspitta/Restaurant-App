//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Michael Hu on 08-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import UIKit

//MARK: - Classes

class OrderConfirmationViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    var minutes: Int!
    
    //MARK: - Overrides
    
    override func viewDidLoad() {

        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes) minutes."

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
