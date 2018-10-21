//
//  AddRegistrationTableViewController.swift
//  Hotel
//
//  Created by Timur Saidov on 21/10/2018.
//  Copyright © 2018 Timur Saidov. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text else {
            return
        }
        
        print(firstName, lastName, email)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

}
