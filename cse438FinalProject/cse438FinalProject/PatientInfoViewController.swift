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

class PatientInfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
   
    
    
    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var insuranceProvider: UILabel!
    @IBOutlet weak var initialBackground: UIView!
    @IBOutlet weak var initials: UILabel!
    
    @IBOutlet weak var patientHistoryCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOADED")
        // ALL INFO RELATING TO LOGGED IN USER
        // Can be placed anywhere, just in here for easy access
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let insurance = UserDefaults.standard.string(forKey: "insurance")
        let name = UserDefaults.standard.string(forKey: "username")
        let docID = UserDefaults.standard.string(forKey: "docID")
        print(userID)
        
        initialBackground.layer.cornerRadius = 120;

        var initialsText = ""
                
        initialsText = String(name?.first ?? " ")
        
        print(initialsText)
        
        if(name?.contains(" ") == true){
            var lastName = name?.components(separatedBy: " ").last
            initialsText = initialsText + String(lastName?.first ?? " ")
            
            print(initialsText)
        }
        
        initials.text = initialsText.uppercased()
        
        //set labels to user info
        patientName.text = name
        //age.text =
        insuranceProvider.text = insurance
        
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
            // do stuff below once query has finished
            // data holds all test results
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 1
       }
           
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patientHistoryCell", for: indexPath)

// set testDate label to date of historical tests for each cell
        
        
        return cell
        
       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "testResults") as! TestResultsViewController
        
        // TODO update title on next page
        // TODO get what test is clicked on and use that from questions dict
        
//        detailView.mainViewController = self
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
}
