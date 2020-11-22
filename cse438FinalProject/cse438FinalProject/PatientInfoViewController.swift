//
//  PatientInfoViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit

class PatientInfoViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {

        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
