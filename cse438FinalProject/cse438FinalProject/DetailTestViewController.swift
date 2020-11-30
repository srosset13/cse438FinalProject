//
//  DetailTestViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/29/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class DetailTestViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCell
        cell.crit0Label.text = "Eyes don't track"
        cell.questionLabel.text = "Eyes Follow Moving Person"
        cell.crit1Label.text = "Eyes track Briefly"
        cell.crit2Label.text = "Eyes track person to left and right"
//        let index = indexPath.row + (3 * indexPath.section)
//        if theImageCache[index] != nil {
//            cell.imageView?.image = theImageCache[index]
//        }
//        cell.movieTitle.text = theData?.results[index].title
//        cell.layer.borderColor = UIColor.darkGray.cgColor
//        cell.layer.borderWidth = 0.5
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //return allQuestions.count
        return 5
    }
    
    
    @IBOutlet weak var questionsCollection: UICollectionView!
    
    override func viewDidLoad() {
        setUpCollectionView()
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        DispatchQueue.global().async {
            do{
                //self.fetchQuestions()
                DispatchQueue.main.async {
//                    self.spinner.isHidden = true
//                    self.spinner.stopAnimating()
                   self.questionsCollection.reloadData()
                }
            }catch{
                print("ERROR")
            }
        }
        
    }
    
    func setUpCollectionView(){
        questionsCollection.dataSource = self
        questionsCollection.delegate = self
    }
    
    var allQuestions: [Question] = []
    func fetchQuestions(){
        print("GETTING QUESTINONS")
        let db = Firestore.firestore()
        db.collection("fineMotorQuestions").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
//                    let a  = try? JSONSerialization.data(withJSONObject: data, options: [])
//                    let b = try? JSONDecoder().decode(Question.self, from: a!)
                    let new_question = Question(Crit0: try? data["Crit0"] as! String, Crit1: try? data["Crit1"] as! String, Crit2: try? data["Crit2"] as! String, Question: try? data["Question"] as! String, StartingPoint: "")
                    self.allQuestions.append(new_question)
                    //allQuestions.append(document.data())
//                    print("\(document.documentID) => \(document.data())")
                }
                
            }
        }
        
        //Probably do a Cache Thing here
    }

    
}
