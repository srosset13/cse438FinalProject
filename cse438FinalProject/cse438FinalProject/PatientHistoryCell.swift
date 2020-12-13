//
//  PatientHistoryCell.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/20/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import UIKit

class PatientHistoryCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UIButton!
    
    @IBOutlet weak var cognitiveScore: UILabel!
    @IBOutlet weak var receptiveScore: UILabel!
    @IBOutlet weak var expressiveScore: UILabel!
    @IBOutlet weak var fineMotorScore: UILabel!
    @IBOutlet weak var grossMotorScore: UILabel!
    

}

struct PatientHistory: Decodable {
    var CGRaw: Int?
    var CGGross: Int?
    var RCRaw: Int?
    var RCGross: Int?
    var ECRaw: Int?
    var ECGross: Int?
    var FMRaw: Int?
    var FMGross: Int?
    var GMRaw: Int?
    var GMGross: Int?
    var date: String?
}
