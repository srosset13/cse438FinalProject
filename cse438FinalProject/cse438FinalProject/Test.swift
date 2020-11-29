//
//  Test.swift
//  cse438FinalProject
//
//  Created by Marissa Friedman on 11/29/20.
//  Copyright © 2020 Marissa Friedman. All rights reserved.
//

import Foundation
import UIKit

class Test {
    
    var date: String
    var patientId: String
    
    var cognitive: [Int] = []
    var receptiveCommunication: [Int] = []
    var expressiveCommunication: [Int] = []
    var fineMotor: [Int] = []
    var grossMotor: [Int] = []
    
    var finalScores: [Int] = []
    
    init( date: String, patientId: String) {
        self.date = date
        self.patientId = patientId
        
    }
    
}
