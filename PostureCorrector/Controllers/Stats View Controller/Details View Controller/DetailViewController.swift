//
//  DetailViewController.swift
//  PostureCorrector
//
//  Created by Neha Nagabothu on 11/23/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

import UIKit
//import SwiftUI
import Foundation

class DetailViewController: UIViewController {
    
    var appTitle: UILabel!
    var dateTitle: UILabel!
    var durationTitle: UILabel!
    var timeTitle: UILabel!
    var scoreTitle: UILabel!
    var scorePercentValueTitle: UILabel!
    var tempBack: UIButton!
    
    var duration1 = ""
    var score1 = ""
    var score2 = ""
    var date1 = ""
    var sessionIndex: Int!
    //var sesh1 : NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor.background
        let currSession = UserData.userSessions[sessionIndex]
        let BPostureCount = currSession.value(forKeyPath: "badPostureCount") as? Double
        let TPostureCount = currSession.value(forKeyPath: "totalPostureCount") as? Double
        
        let cellScore = 1 - (BPostureCount! / TPostureCount!)
        
        appTitle = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.width-60, height: 60))
        appTitle.font = .boldSystemFont(ofSize: 50)
        appTitle.textColor = .white
        appTitle.textAlignment = .center
        appTitle.center.x = self.view.center.x
        
        appTitle.text = "your session"
        view.addSubview(appTitle)
        
        dateTitle = UILabel(frame: CGRect(x: 30, y: appTitle.frame.maxY + 20, width: view.frame.width-60, height: 60))
        dateTitle.font = .boldSystemFont(ofSize: 35)
        dateTitle.textColor = .white
        dateTitle.textAlignment = .center
        dateTitle.text = currSession.value(forKeyPath: "date") as? String
        view.addSubview(dateTitle)
        
        durationTitle = UILabel(frame: CGRect(x: 60, y: dateTitle.frame.maxY + 80, width: view.frame.width-120, height: 30))
        durationTitle.font = .boldSystemFont(ofSize: 35)
        durationTitle.text = "duration"
        durationTitle.textColor = .white
        durationTitle.textAlignment = .center
        view.addSubview(durationTitle)
        
        timeTitle = UILabel(frame: CGRect(x: 60, y: durationTitle.frame.maxY + 20, width: view.frame.width-120, height: 30))
        timeTitle.font = .boldSystemFont(ofSize: 25)
        let durationDouble = Double(currSession.value(forKeyPath: "sessionDuration") as! String)!
        durationString(duration: durationDouble)
        timeTitle.text = duration1
        timeTitle.textColor = .white
        timeTitle.textAlignment = .center
        view.addSubview(timeTitle)

        
        scoreTitle = UILabel(frame: CGRect(x: 60, y: timeTitle.frame.maxY + 80, width: view.frame.width-120, height: 30))
        scoreTitle.font = .boldSystemFont(ofSize: 35)
        scoreTitle.text = "score"
        scoreTitle.textColor = .white
        scoreTitle.textAlignment = .center
        view.addSubview(scoreTitle)
        
        scorePercentValueTitle = UILabel(frame: CGRect(x: 60, y: scoreTitle.frame.maxY + 20, width: view.frame.width-120, height: 30))
        scorePercentValueTitle.font = .boldSystemFont(ofSize: 25)
        let doubleStr = String(format: "%.2f", cellScore*100)
        scorePercentValueTitle.text = doubleStr + "%"
        scorePercentValueTitle.textColor = .white
        scorePercentValueTitle.textAlignment = .center
        view.addSubview(scorePercentValueTitle)
        
    }
    
    func durationString(duration: Double) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short

        duration1 = formatter.string(from: TimeInterval(duration))!
    }
    
//    //go to my stats page
//    @objc func backToStatsView() {
//        performSegue(withIdentifier: "backToStats", sender: self)
//
//    }

    
}
