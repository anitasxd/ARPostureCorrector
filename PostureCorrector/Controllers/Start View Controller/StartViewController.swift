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
    
    var logoIcon: UIImageView!
    
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
        appTitle = UILabel(frame: CGRect(x: 30, y: 120, width: view.frame.width-60, height: 70))
        appTitle.font = .boldSystemFont(ofSize: 60)
        appTitle.textColor = .white
        appTitle.center.x = self.view.center.x
        appTitle.textAlignment = .center
        
        appTitle.text = "Posie"
        view.addSubview(appTitle)
        
        logoIcon  =  UIImageView(frame: CGRect(x:view.frame.width/2, y: appTitle.frame.maxY + 20, width: 80, height: 80))
        logoIcon.center.x = self.view.center.x
        logoIcon.contentMode = .scaleAspectFit
        //        gradientScaleImage.center = self.view.center
        logoIcon.clipsToBounds = true
        //        gradientScaleImage.image = UIImage(named: "gradientScale")
        logoIcon.image = UIImage(named: "100logo")
        view.addSubview(logoIcon)
        
        newSeshTitle = UIButton(frame: CGRect(x: 60, y: logoIcon.frame.maxY + 100, width: view.frame.width-120, height: 50))
        newSeshTitle.setTitle("new session", for: .normal)
        newSeshTitle.center.x = self.view.center.x
        newSeshTitle.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        newSeshTitle.backgroundColor = UIColor.purple3
        newSeshTitle.layer.borderWidth = 0
        newSeshTitle.layer.cornerRadius = newSeshTitle.frame.height/4
        newSeshTitle.setTitleColor(.white, for: .normal)
        newSeshTitle.addTarget(self, action: #selector(goToSessionView), for: .touchUpInside)
        view.addSubview(newSeshTitle)
        
        statsTitle = UIButton(frame: CGRect(x: 60, y: newSeshTitle.frame.maxY + 40, width: view.frame.width-120, height: 50))
        statsTitle.setTitle("my stats", for: .normal)
        statsTitle.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        statsTitle.center.x = self.view.center.x
        statsTitle.backgroundColor = UIColor.purple3
        statsTitle.layer.borderWidth = 0
        statsTitle.layer.cornerRadius = statsTitle.frame.height/4
        statsTitle.setTitleColor(.white, for: .normal)
        statsTitle.addTarget(self, action: #selector(goToStatsView), for: .touchUpInside)
        view.addSubview(statsTitle)
        
        let settingsIcon = UIImage(named: "settings")
        settingsBtn = UIButton(frame: CGRect(x: view.frame.width * 8.5 / 10, y: 40, width: 40, height: 40))
        settingsBtn.setImage(settingsIcon, for: UIControl.State.normal)
        settingsBtn.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        view.addSubview(settingsBtn)
        
    }
    
    //go to new session page
    @objc func goToSessionView() {

        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            performSegue(withIdentifier: "toSession", sender: self)
        } else {
            let actionController: UIAlertController = UIAlertController(title: "Camera is not available",message: "", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void  in
                       //Just dismiss the action sheet
            }
            actionController.addAction(cancelAction)
            self.present(actionController, animated: true, completion: nil)
        }
        
        
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

