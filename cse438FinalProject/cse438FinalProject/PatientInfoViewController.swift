//
//  PatientInfoViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class PatientInfoViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOADED")
        // ALL INFO RELATING TO LOGGED IN USER
        // Can be placed anywherejust in here for easy access
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let insurance = UserDefaults.standard.string(forKey: "insurance")
        let name = UserDefaults.standard.string(forKey: "username")
        let docID = UserDefaults.standard.string(forKey: "docID")
        print(userID)
        let db = Firestore.firestore()
        //TODO look up test results
        var data = [[String:Any]]()
        db.collection("testResults").whereField("userID", isEqualTo: userID).getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    data.append(document.data())
                    
                }
            }
            //do stuff below once query has finished
            print(data)
        })
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        // maybe remove the keys instead of setting to nil?? idk
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(nil, forKey: "userID")
        UserDefaults.standard.synchronize()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
