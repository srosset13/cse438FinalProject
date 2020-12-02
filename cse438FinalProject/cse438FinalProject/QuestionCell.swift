//
//  QuestionCell.swift
//  cse438FinalProject
//
//  Created by Nathan Ostdiek on 11/20/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var crit0Label: UILabel!
    @IBOutlet weak var crit1Label: UILabel!
    @IBOutlet weak var crit2Label: UILabel!
    @IBOutlet weak var answerBar: UISegmentedControl!

    
}
struct DatabaseResults {
    let questions: [Question]
}

struct Question: Decodable {
    let Crit0: String?
    let Crit1: String?
    let Crit2: String?
    let Question: String?
    let StartingPoint: String?
    var value: Int?
}
