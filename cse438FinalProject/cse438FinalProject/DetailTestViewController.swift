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
        cell.crit0Label.text = allQuestions[indexPath[0]].Crit0
        cell.questionLabel.text = allQuestions[indexPath[0]].Question
        cell.crit1Label.text = allQuestions[indexPath[0]].Crit1
        cell.crit2Label.text = allQuestions[indexPath[0]].Crit2
        return cell
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allQuestions.count
    }
    //updates value in 
    @IBAction func cellValueChanged(_ sender: AnyObject) {
        guard let cell = sender.superview?.superview as? QuestionCell else {
            return
        }
        let indexPath = questionsCollection.indexPath(for: cell)
        allQuestions[indexPath![0]].value = cell.answerBar.selectedSegmentIndex
        print(allQuestions[indexPath![0]])
    }
    
    @IBOutlet weak var questionsCollection: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
//        self.spinner.isHidden = false
        setUpCollectionView()
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        DispatchQueue.global().async {
            do{
                self.fetchQuestions()
                
                DispatchQueue.main.async {
                    
                   //self.questionsCollection.reloadData()
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
        let db = Firestore.firestore()
        //TODO update this to the specific test
        db.collection("fineMotorQuestions").getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()

                    let new_question = Question(Crit0: try? data["Crit0"] as! String, Crit1: try? data["Crit1"] as! String, Crit2: try? data["Crit2"] as! String, Question: try? data["Question"] as! String, StartingPoint: "", value: nil)
                    self.allQuestions.append(new_question)

                }

            }
//            self.spinner.isHidden = true
//            self.spinner.stopAnimating()
            self.questionsCollection.reloadData()
        })
        
        //Probably do a Cache Thing here
    }

    
}
