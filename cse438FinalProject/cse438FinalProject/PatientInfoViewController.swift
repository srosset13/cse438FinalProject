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
    
    func formatAge(age: String) -> String{
        var s = age.split(separator: " ")
        let day = s[1].replacingOccurrences(of: ",", with: "")
        var str = "\(s[0])/\(day)/\(s[2])"
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let someDate = formatter.date(from: str)
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year,.month], from: someDate!, to: Date())
        let year = ageComponents.year!
        let month = ageComponents.month!
        UserDefaults.standard.set(year, forKey: "AgeYear")
        UserDefaults.standard.set(month, forKey: "AgeMonth")

        return "\(year) Years and \(month) Months"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // ALL INFO RELATING TO LOGGED IN USER
        let userID = UserDefaults.standard.integer(forKey: "userID")
        let insurance = UserDefaults.standard.string(forKey: "insurance")
        let name = UserDefaults.standard.string(forKey: "username")
        let DOB = UserDefaults.standard.string(forKey: "DOB")
        
        initialBackground.layer.cornerRadius = 120;

        var initialsText = ""
                
        initialsText = String(name?.first ?? " ")
        
        print(initialsText)
        
        if(name?.contains(" ") == true){
            var lastName = name?.components(separatedBy: " ").last
            initialsText = initialsText + String(lastName?.first ?? " ")
            
            print(initialsText)
        }
        age.text = formatAge(age: DOB!)
        initials.text = initialsText.uppercased()
        
        //set labels to user info
        patientName.text = name
        //age.text =
        insuranceProvider.text = insurance
        
        let db = Firestore.firestore()
        var data = [[String:Any]]()
        db.collection("testResults").whereField("userID", isEqualTo: userID).getDocuments(completion: {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    // TODO get all data fields from query
                    let new_result = PatientHistory(cognitiveScore: try? data["CognitiveRaw"] as? String)
                    self.patientResults.append(new_result)
                }
            }
            // do stuff below once query has finished
            // data holds all test results
            self.patientHistoryCV.reloadData()
            print(self.patientResults)
        })
    }
    var patientResults:[PatientHistory] = []
    @IBAction func logoutBtn(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.set(nil, forKey: "userID")
        UserDefaults.standard.synchronize()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 1
       }
           
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "patientHistoryCell", for: indexPath) as! PatientHistoryCell
        
        // TODO set values from patientResults to labels
        cell.cognitiveScore.text = patientResults[indexPath.section].cognitiveScore
                
        
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
