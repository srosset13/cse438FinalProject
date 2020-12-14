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

class TestResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rawScores: [String: Int] = [:]
    var grossScores: [String: Int] = [:]
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 1
     }
     
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tests.count
     }
     var tests = ["Cognitive", "Receptive Communication", "Expressive Communication", "Fine Motor", "Gross Motor"]
    var tests2 = ["CG", "RC", "EC", "FM", "GM"]
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "testResults", for: indexPath) as! testResultsCell
        cell.SubcategoryName.text = tests[indexPath.section]
        cell.rawScoreLabel.text = "Raw Score: \(rawScores[tests2[indexPath.section]]!)"
        cell.grossScoreLabel.text = "Gross Score: \(grossScores[tests2[indexPath.section]]!)"
         return cell

     }
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
         return CGSize(width: 800, height: 80);
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 10;
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 10;
     }
        
    
    @IBAction func backBtn(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");
        self.navigationController?.pushViewController(mainApp, animated: true)
    }
    
    
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainApp = storyboard.instantiateViewController(withIdentifier: "tabBarController");
            self.navigationController?.pushViewController(mainApp, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func exportResults(_ sender: Any) {
        //Create the UIImage
        let renderer = UIGraphicsImageRenderer(size: view.frame.size)
        let image = renderer.image(actions: { context in
            view.layer.render(in: context.cgContext)
        })
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        sendAlert(title: "Saved", message: "Results have been successfully saved to photo library")
    }
    
}
