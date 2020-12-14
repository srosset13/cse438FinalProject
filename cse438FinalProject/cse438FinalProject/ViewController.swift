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
        // NATE INSERTING QUESTIONS TO DATABASE, PLZ IGNORE THANKS
//         let db = Firestore.firestore()
//        let data = db.document("GSVChart/0")
//        print(data)
//        let docData : [String: Any] = [
//            "Crit0": "Uses less advanced grasp",
//            "Crit1": "Grasps pellet using partial thumb opposition grasp",
//            "Crit2": "Grasps pellet using neat pincer grasp",
//            "Question": "Pellet Grasp Series: Neat Pincer",
//            "StartPoint": ""
//
//        ]
//        db.collection("fineMotorQuestions").document("18").setData(docData) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//        let docData2 : [String: Any] = [
//            "Crit0": "Does not attempt to turn pages",
//            "Crit1": "Occasionally turns 1 page at a time but typically turns several pages",
//            "Crit2": "Consistently and successfully attempts to turn 1 page at a time",
//            "Question": "Turns Pages of Book",
//            "StartPoint": ""
//
//        ]
//        db.collection("fineMotorQuestions").document("19").setData(docData2) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
//        let docData3 : [String: Any] = [
//            "Crit0": "Does not grasp pencil firmly in palm",
//            "Crit1": "Grasps pencil using fingers and thumb opposition but does not make a mark",
//            "Crit2": "Grasps pencil using palmar grasp (palmar supinate or radial cross palmar) and makes a mark on paper",
//            "Question": "Penci Grasp Series: Palmar",
//            "StartPoint": ""
//
//        ]
//        db.collection("fineMotorQuestions").document("20").setData(docData3) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let formattedID = Int(patientID.text ?? "")
        let db = Firestore.firestore()
        if(formattedID != nil){
            db.collection("patients").whereField("PatientID", isEqualTo: formattedID!).getDocuments(completion: { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()

                        //let attemptedPassword = try? data["Password"] as! String
                        if let attemptedPassword = data["Password"] as? String{
                            if (self.password.text! == attemptedPassword) {
                                let ins = data["insurance"]
                                let name = data["Name"]
                                self.loggedIn = true
                                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                UserDefaults.standard.set(formattedID!, forKey: "userID")
                                UserDefaults.standard.set(name, forKey: "username")
                                UserDefaults.standard.set(ins, forKey: "insurance")
                                UserDefaults.standard.set(data["DOB"], forKey: "DOB")
                                UserDefaults.standard.synchronize()
                            }
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

