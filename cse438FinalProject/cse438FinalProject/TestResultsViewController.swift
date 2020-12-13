//
//  TestResultsViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 12/10/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class TestResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var scores: [String: Int] = [:]
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 1
     }
     
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 5
     }
     var tests = ["Cognitive", "Receptive Communication", "Expressive Communication", "Fine Motor", "Gross Motor"]
    var tests2 = ["CG", "RC", "EC", "FM", "GM"]
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testResults", for: indexPath)

         let category = UILabel(frame: CGRect(x:20, y:(1/3*cell.bounds.size.height), width:3*cell.bounds.size.width/4, height: cell.bounds.size.height/3))
         
         category.text = tests[indexPath.section]
         
         category.adjustsFontSizeToFitWidth = true
         cell.contentView.addSubview(category)
        let scoretext = UILabel(frame: CGRect(x:500, y:(1/3*cell.bounds.size.height), width:3*cell.bounds.size.width/4, height: cell.bounds.size.height/3))
        print(tests2[indexPath.section])
        scoretext.text = "Raw Score: \(scores[tests2[indexPath.section]]!)"
         cell.contentView.addSubview(scoretext)
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
    
    @IBAction func exportResults(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["nostdiek1@gmail.com"])
            mail.setSubject("Bayley Test Results")
            mail.setMessageBody("Hi", isHTML: true)
            mail.mailComposeDelegate = self
//            if let filePath = Bundle.main.path(forResource: "sampleData", ofType: "json") {
//               if let data = NSData(contentsOfFile: filePath) {
//                  mail.addAttachmentData(data as Data, mimeType: "application/json" , fileName: "sampleData.json")
//               }
//            }
            present(mail, animated: true)
         }
         else {
            print("Email cannot be sent")
         }
    }
}
