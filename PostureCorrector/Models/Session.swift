//
//  Session.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation

class Session {
    var date: String!
    var postureCount: Int
    var duration: Double
    var score: Double
    
    init(userDate: String, userPosture: Int, userDuration: Double){
        date = userDate
        postureCount = userPosture
        duration = userDuration
        score = Double(postureCount) / duration * 100.0
    }
    
}


