//
//  NewTestViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit

class NewTestViewController: UIViewController{
    
    @IBAction func submitTestBtn(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
        //update collection view in history
        //call whatever the action is for touching the collection view of this test in history
        //unhide the nav bar??
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
