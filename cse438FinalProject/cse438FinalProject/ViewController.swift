//
//  ViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/16/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet weak var patientID: UITextField!
    @IBOutlet weak var password: UITextField!
    var loggedIn = false
    
    @IBAction func newPatientBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let newProfile = storyboard.instantiateViewController(withIdentifier: "newPatientProfID") as! NewPatientProfile;

        self.navigationController?.pushViewController(newProfile, animated: true)
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        


        let formattedID = Int(patientID.text ?? "")
        print(formattedID)
        print(password.text)
        
        let db = Firestore.firestore()
        if(formattedID != nil){
            db.collection("patients").whereField("PatientID", isEqualTo: formattedID!).getDocuments(completion: { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let attemptedPassword = try? data["Password"] as! String
                        if (self.password.text! == attemptedPassword) {
                            print("CORRECT CREDS")
                            self.loggedIn = true
                        }
                        
                        
                    }
                }
                if(self.loggedIn){
                    let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");
                    self.navigationController?.pushViewController(mainApp, animated: true)
                    self.patientID.text = ""
                    self.password.text = ""
                    
                }
                else{
                    print("INCORRECT CREDS")
                }
                self.loggedIn = false
            })
        }

    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true

        
    }


}

