//
//  StartViewController.swift
//  PostureCorrector
//
//  Created by Neha Nagabothu on 10/19/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import UIKit
//import SwiftUI
import Foundation

class StartViewController: UIViewController {
    
    var appTitle: UILabel!
    var newSeshTitle: UIButton!
    var statsTitle: UIButton!
    var settingsIcon: UIImageView!
    var settingsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        
        view.backgroundColor = UIColor(red:0.47, green:0.50, blue:0.79, alpha:1.0)
        
        appTitle = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.width-60, height: 60))
        appTitle.font = .boldSystemFont(ofSize: 50)
        appTitle.textColor = .white
        appTitle.textAlignment = .center
        appTitle.text = "posity"
        view.addSubview(appTitle)
        
        newSeshTitle = UIButton(frame: CGRect(x: 60, y: 350, width: view.frame.width-120, height: 30))
        newSeshTitle.titleLabel?.font = .boldSystemFont(ofSize: 35)
        newSeshTitle.setTitle("start session", for: .normal)
        newSeshTitle.addTarget(self, action: #selector(goToSessionView), for: .touchUpInside)
        view.addSubview(newSeshTitle)
        
        statsTitle = UIButton(frame: CGRect(x: 60, y: 600, width: view.frame.width-120, height: 30))
        statsTitle.titleLabel?.font = .boldSystemFont(ofSize: 35)
        statsTitle.setTitle("my progress", for: .normal)
        statsTitle.addTarget(self, action: #selector(goToSessionView), for: .touchUpInside)
        view.addSubview(statsTitle)
        
        let settingsIcon = UIImage(named: "settings")
        
        settingsBtn = UIButton(frame: CGRect(x: 300, y: 30, width: 40, height: 40))
        settingsBtn.setImage(settingsIcon, for: UIControl.State.normal)
        settingsBtn.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        view.addSubview(settingsBtn)
        
    }
    
    @objc func goToSessionView() {
        performSegue(withIdentifier: "toSession", sender: self)
        
    }
    
    @objc func goToSettings() {
        performSegue(withIdentifier: "toSettings", sender: self)
        
    }
    
    
}

