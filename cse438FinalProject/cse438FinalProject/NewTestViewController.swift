//
//  NewTestViewController.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/22/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit

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

        let detailView = storyboard.instantiateViewController(withIdentifier: "detailTestView");

        self.navigationController?.pushViewController(detailView, animated: true)

    }
    
    
    @IBAction func submitTestBtn(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
        //update collection view in history
        //call whatever the action is for touching the collection view of this test in history
        //unhide the nav bar??
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()

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
