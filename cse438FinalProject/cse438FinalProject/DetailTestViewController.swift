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
        if(allQuestions[indexPath[0]].value != nil){
            cell.answerBar.selectedSegmentIndex = allQuestions[indexPath[0]].value ?? 0
        }
        
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
    }
    
    @IBOutlet weak var questionsCollection: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var testCategory: String? = ""
    let otherVC = NewTestViewController()
    
    override func viewDidLoad() {
//        self.spinner.isHidden = false
        
        setUpCollectionView()
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        questionsCollection.reloadData()

        
    }
    var mainViewController: NewTestViewController?
    var allQuestions: [Question] = []
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            // TODO pass in correct key (test name)
            mainViewController?.onUserAction(data: allQuestions, key: "cognitiveQuestions")

        }
    }

    func setUpCollectionView(){
        questionsCollection.dataSource = self
        questionsCollection.delegate = self
    }
    
    
    
}
