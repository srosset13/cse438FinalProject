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

class NewTestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    var tests = ["Cognitive", "Receptive Communication", "Expressive Communication", "Fine Motor", "Gross Motor"]
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCategory", for: indexPath)
        
        
        cell.bounds.size = CGSize(width: 800, height: 200)
        let category = UILabel(frame: CGRect(x:20, y:(1/3*cell.bounds.size.height), width:3*cell.bounds.size.width/4, height: cell.bounds.size.height/3))
        category.text = tests[indexPath.section]
        category.adjustsFontSizeToFitWidth = true
        cell.contentView.addSubview(category)
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailView = storyboard.instantiateViewController(withIdentifier: "detailTestView") as! DetailTestViewController
        
        // TODO update title on next page
        // TODO get what test is clicked on and use that from questions dict
        detailView.allQuestions = questions["cognitiveQuestions"] ?? []
        detailView.mainViewController = self
        self.navigationController?.pushViewController(detailView, animated: true)
        
        
    }
    func onUserAction(data: [Question], key: String){
        print("DATA recieved")
        questions[key] = data
    }

    
    @IBAction func submitTestBtn(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
        //update collection view in history
        //call whatever the action is for touching the collection view of this test in history
        //unhide the nav bar??
        
        // TODO loop through all keys in questions[] and add up values and look up in chart
        
        // empty all questions ... prob shouldn't do this
        // TODO prob don't reload these values each time
        for (key,value) in questions {
            questions[key] = []
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
    var questions:[String : [Question]] = ["fineMotorQuestions": [], "cognitiveQuestions": [], "grossMotorQuestions": [], "expressiveCommunicationQuestions": [],"receptiveCommunicationQuestions": []]
    func fetchQuestions(){
        let db = Firestore.firestore()

        for (key,value) in questions {
            //TODO update this to the specific test
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

                print("DONE")
            })
            
            //Probably do a Cache Thing here
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    
    func setUpCollectionView() {
        
        if(collectionView != nil){
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "testCategory")

        }
                
    }
}

