//
//  SubcategoryTest.swift
//  cse438FinalProject
//
//  Created by Nathan Ostdiek on 12/11/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit

class SubcategoryTest: UICollectionViewCell {
    
    @IBOutlet weak var Progress: UILabel!
    @IBOutlet weak var SubcategoryName: UILabel!
    
    func complete(){
        Progress.text = "Completed"
        Progress.textColor = .green
    }
}
