//
//  ViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/16/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var newProfile = NewPatientProfile()
    
    @IBAction func newPatientBtn(_ sender: Any) {
        
        navigationController?.pushViewController(newProfile, animated: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

