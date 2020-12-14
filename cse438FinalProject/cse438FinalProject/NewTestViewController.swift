//
//  NewTestViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class NewTestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!

    var tests = ["Cognitive", "Receptive Communication", "Expressive Communication", "Fine Motor", "Gross Motor"]
    
    var tests2 = ["cognitiveQuestions", "receptiveCommunicationQuestions", "expressiveCommunicationQuestions", "fineMotorQuestions", "grossMotorQuestions"]
    
    var questions:[String : [Question]] = ["fineMotorQuestions": [], "cognitiveQuestions": [], "grossMotorQuestions": [], "expressiveCommunicationQuestions": [],"receptiveCommunicationQuestions": []]
    
    var index: IndexPath?
    
    var currentTest = Test(date: Date(), patientId: UserDefaults.standard.integer(forKey: "userID"))
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCategory", for: indexPath) as! SubcategoryTest
        cell.SubcategoryName.text = tests[indexPath.section]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 800, height: 80);
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 10;
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "detailTestView") as! DetailTestViewController

        detailView.allQuestions = questions[tests2[indexPath.section]] ?? []
        detailView.mainViewController = self
        detailView.name = tests[indexPath.section]
        detailView.keyQ = tests2[indexPath.section]
        self.navigationController?.pushViewController(detailView, animated: true)
        
        index = indexPath
    }
    func onUserAction(data: [Question], key: String){
        questions[key] = data
        
        updateProgress(key: key)
    }

    @IBAction func submitTestBtn(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
        
        var cognitiveQuestions = 0
        var receptiveCommunicationQuestions = 0
        var expressiveCommunicationQuestions = 0
        var fineMotorQuestions = 0
        var grossMotorQuestions = 0
        
        for (key,value) in questions {
            if key == "cognitiveQuestions"{
                if let questionlist = questions[key]{
                    for question in questionlist{
                        cognitiveQuestions = cognitiveQuestions + (question.value ?? 0)
                    }
                }
            }
            if key == "receptiveCommunicationQuestions"{
                if let questionlist = questions[key]{
                    for question in questionlist{
                        receptiveCommunicationQuestions = receptiveCommunicationQuestions + (question.value ?? 0)
                    }
                }
            }
            if key == "expressiveCommunicationQuestions"{
                if let questionlist = questions[key]{
                    for question in questionlist{
                        expressiveCommunicationQuestions = expressiveCommunicationQuestions + (question.value ?? 0)
                    }
                }
            }
            if key == "fineMotorQuestions"{
                if let questionlist = questions[key]{
                    for question in questionlist{
                        fineMotorQuestions = fineMotorQuestions + (question.value ?? 0)
                    }
                }
            }
            if key == "grossMotorQuestions"{
                if let questionlist = questions[key]{
                    for question in questionlist{
                        grossMotorQuestions = grossMotorQuestions + (question.value ?? 0)
                    }
                }
            }
        }
        
        currentTest.rawFinalScores["CG"] = cognitiveQuestions
        currentTest.rawFinalScores["RC"] = receptiveCommunicationQuestions
        currentTest.rawFinalScores["EC"] = expressiveCommunicationQuestions
        currentTest.rawFinalScores["FM"] = fineMotorQuestions
        currentTest.rawFinalScores["GM"] = grossMotorQuestions
        print(currentTest.rawFinalScores)
        
        let db = Firestore.firestore()

        var counter = 0
        for (key,score) in self.currentTest.rawFinalScores {
            db.collection("GSVChart").document(String(score)).getDocument(completion: {(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let data = querySnapshot!.data()
                    let score = data![key] as? String
                    self.currentTest.calcFinalScores[key] = Int(score!)
                }
                counter += 1
                if (counter == 5){
                    db.collection("testResults").addDocument(data: [
                        "userID": self.currentTest.patientId,
                        "date": self.currentTest.date,
                        "CGRaw": self.currentTest.rawFinalScores["CG"],
                        "CGGross": self.currentTest.calcFinalScores["CG"],
                        "RCRaw":self.currentTest.rawFinalScores["RC"],
                        "RCGross": self.currentTest.calcFinalScores["RC"],
                        "ECRaw": self.currentTest.rawFinalScores["EC"],
                        "ECGross": self.currentTest.calcFinalScores["EC"],
                        "FMRaw": self.currentTest.rawFinalScores["FM"],
                        "FMGross": self.currentTest.calcFinalScores["FM"],
                        "GMRaw": self.currentTest.rawFinalScores["GM"],
                        "GMGross": self.currentTest.calcFinalScores["GM"],
                    ])
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let testResultView = storyboard.instantiateViewController(withIdentifier: "testResults") as! TestResultsViewController
                    testResultView.rawScores = self.currentTest.rawFinalScores
                    testResultView.grossScores = self.currentTest.calcFinalScores
                     self.navigationController?.pushViewController(testResultView, animated: true)
                }
            })
        }
    }

    var fineMotorQuestions = [Question]()
    var cognitiveQuestions = [Question]()
    var grossMotorQuestions = [Question]()
    var expressiveCommunicationQuestions = [Question]()
    var receptiveCommunicationQuestions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()

    }
    @IBAction func newTestStarted(_ sender: Any) {
        for (key,value) in questions {
            questions[key] = []
        }
        DispatchQueue.global().async {
            do{
                self.fetchQuestions()
                DispatchQueue.main.async {
                }
                }catch{
                    print("ERROR")
                }
        }
    }

    func fetchQuestions(){
        let db = Firestore.firestore()
        for (key,value) in questions {
            db.collection(key).getDocuments(completion: { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let new_question = Question(Crit0: try? data["Crit0"] as! String, Crit1: try? data["Crit1"] as! String, Crit2: try? data["Crit2"] as! String, Question: try? data["Question"] as! String, StartingPoint: "", value: nil)
                        
                        self.questions[key]?.append(new_question)
                    }
                }
            })
        }
    }
    
    func updateProgress(key: String){
        var counter = 0
        if let name = questions[key] {
            for cell in name{
                if cell.isFilled {
                    counter = counter + 1
                }
            }
            if counter == questions[key]?.count{
                if index != nil  && questions[key]?.count != 0 {
                    let cell = collectionView.cellForItem(at: index!) as! SubcategoryTest
                    cell.complete()
                }
            } else {
                let cell = collectionView.cellForItem(at: index!) as! SubcategoryTest
                cell.Progress.text = "In Progress"
            }
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpCollectionView() {
        if(collectionView != nil){
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
}

