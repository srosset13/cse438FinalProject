//
//  NewPatientProfile.swift
//  cse438FinalProject
//
//  Created by Lucinda Gillespie on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit

class NewPatientProfile: UIViewController{
    
    @IBAction func createNewProfBtn(_ sender: Any) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");

        self.navigationController?.pushViewController(mainApp, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
