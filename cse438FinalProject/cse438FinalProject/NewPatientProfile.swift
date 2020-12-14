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
    @IBOutlet weak var dateOfBirth: UITextField!
    
    let datePicker = UIDatePicker()
    
    func createDatePicker(){
        //gets current date - can use to find age
        let today = Date()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        dateOfBirth.inputAccessoryView = toolbar
        dateOfBirth.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateOfBirth.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainApp = storyboard.instantiateViewController(withIdentifier: "loginScreenID");
        self.navigationController?.pushViewController(mainApp, animated: true)
    }
    
    @IBAction func createNewProfile(_ sender: Any) {
        let db = Firestore.firestore()
        let formattedID = Int(patientID.text ?? "")
        let formattedPassword = String(password.text ?? "")
        let formattedName = String(name.text ?? "")
        let formattedInsurance = String(insurance.text ?? "")

        if(formattedID != nil){
            db.collection("patients").addDocument(data: [
                "Name" : formattedName,
                "Password": formattedPassword,
                "PatientID" : formattedID!,
                "insurance" : formattedInsurance,
                "DOB": dateOfBirth.text
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
                    UserDefaults.standard.set(self.dateOfBirth.text, forKey: "DOB")
                    UserDefaults.standard.synchronize()
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");

                    self.navigationController?.pushViewController(mainApp, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }
    
}
