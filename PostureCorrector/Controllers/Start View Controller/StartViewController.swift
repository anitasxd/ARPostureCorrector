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
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //navigationController?.navigationBar.barTintColor = UIColor.background
        setupLayout()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor.background
        appTitle = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.width-60, height: 60))
        appTitle.font = .boldSystemFont(ofSize: 50)
        appTitle.textColor = .white
        appTitle.textAlignment = .center
        
        appTitle.text = "posity"
        view.addSubview(appTitle)
        
        newSeshTitle = UIButton(frame: CGRect(x: 60, y: 350, width: view.frame.width-120, height: 30))
        newSeshTitle.titleLabel?.font = .boldSystemFont(ofSize: 35)
        newSeshTitle.setTitle("new session", for: .normal)
        newSeshTitle.addTarget(self, action: #selector(goToSessionView), for: .touchUpInside)
        view.addSubview(newSeshTitle)
        
        statsTitle = UIButton(frame: CGRect(x: 60, y: 600, width: view.frame.width-120, height: 30))
        statsTitle.titleLabel?.font = .boldSystemFont(ofSize: 35)
        statsTitle.setTitle("see my stats", for: .normal)
        statsTitle.addTarget(self, action: #selector(goToStatsView), for: .touchUpInside)
        view.addSubview(statsTitle)
        
        let settingsIcon = UIImage(named: "settings")
        
        settingsBtn = UIButton(frame: CGRect(x: 300, y: 30, width: 40, height: 40))
        settingsBtn.setImage(settingsIcon, for: UIControl.State.normal)
        settingsBtn.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        view.addSubview(settingsBtn)
        
    }
    
    //go to new session page
    @objc func goToSessionView() {
        performSegue(withIdentifier: "toSession", sender: self)
        
    }
    
    //go to my stats page
    @objc func goToStatsView() {
        performSegue(withIdentifier: "toStats", sender: self)
        
    }
    
    //got to settings page
    @objc func goToSettings() {
        performSegue(withIdentifier: "toSettings", sender: self)
        
    }
    
    
}

