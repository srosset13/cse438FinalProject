//
//  NewPatientProfile.swift
//  cse438FinalProject
//
//  Created by Lucinda Gillespie on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit

class NewPatientProfile: UIViewController{
    
    @IBOutlet weak var patientID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var insurance: UITextField!
    
    
    
    @IBAction func createNewProfile(_ sender: Any) {
        
        //write data to firestore
        //create new user
        
        let db = Firestore.firestore()
        let formattedID = Int(patientID.text ?? "")
        let formattedPassword = String(password.text ?? "")
        let formattedName = String(name.text ?? "")
        let formattedInsurance = String(insurance.text ?? "")

        if(formattedID != nil){
            //check to see if patientID has already been registered. If so, do not create a new account
            
            //if the patientID does not exist yet in the database, create a new account:
            db.collection("patients").addDocument(data: [
                "Name" : formattedName,
                "Password": formattedPassword,
                "PatientID" : formattedID!,
                "insurance" : formattedInsurance
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written")
                    //if new user was successfully created, set all global variables to those of the new user (ex. name, id, insurance)
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.set(formattedID!, forKey: "userID")
                    UserDefaults.standard.set(formattedName, forKey: "username")
                    UserDefaults.standard.set(formattedInsurance, forKey: "insurance")
                    //UserDefaults.standard.set(document.documentID, forKey: "docID")
                    UserDefaults.standard.synchronize()
                }
            }
        }
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");

        self.navigationController?.pushViewController(mainApp, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
