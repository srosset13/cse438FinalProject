//
//  ViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/16/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func newPatientBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let newProfile = storyboard.instantiateViewController(withIdentifier: "newPatientProfID") as! NewPatientProfile;

        self.navigationController?.pushViewController(newProfile, animated: true)

        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");

        self.navigationController?.pushViewController(mainApp, animated: true)

    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true

        
    }


}

