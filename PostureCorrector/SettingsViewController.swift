//
//  SettingsViewController.swift
//  PostureCorrector
//
//  Created by Neha Nagabothu on 10/19/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var screenTitle: UILabel!
    var thresholdSlider: UISlider!
    var thresholdLabel: UILabel!
    var thresholdValue: Int = 1
    var durationSlider: UISlider!
    var durationLabel: UILabel!
    var applyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupLayout() {
        
        view.backgroundColor = UIColor(red:0.47, green:0.50, blue:0.79, alpha:1.0)
        
        screenTitle = UILabel(frame: CGRect(x: 30, y: 100, width: view.frame.width-60, height: 60))
        screenTitle.font = .boldSystemFont(ofSize: 50)
        screenTitle.textColor = .white
        screenTitle.textAlignment = .center
        screenTitle.text = "settings"
        view.addSubview(screenTitle)
        
        thresholdSlider = UISlider(frame: CGRect(x: 3 * (view.frame.width/7), y: 200, width: 150, height: 30))
        //        thresholdSlider.addTarget(self, action: Selector(("sliderValueDidChange")),for: .valueChanged)
        view.addSubview(thresholdSlider)
        
        thresholdLabel = UILabel(frame: CGRect(x: 20, y: 190, width: view.frame.width-60, height: 60))
        thresholdLabel.font = .boldSystemFont(ofSize: 22)
        thresholdLabel.textColor = .white
        thresholdLabel.text = "threshold"
        //        thresholdLabel.text = "\(thresholdSlider.value)"
        view.addSubview(thresholdLabel)
        
        thresholdValue = Int(thresholdSlider.value)
        
        durationSlider = UISlider(frame: CGRect(x: 3 * (view.frame.width/7), y: 300, width: 150, height: 30))
        view.addSubview(durationSlider)
        
        durationLabel = UILabel(frame: CGRect(x: 20, y: 290, width: view.frame.width-60, height: 60))
        durationLabel.font = .boldSystemFont(ofSize: 22)
        durationLabel.textColor = .white
        durationLabel.text = "duration"
        view.addSubview(durationLabel)
        
        
        applyButton = UIButton(frame: CGRect(x: view.frame.width/2 - 150, y: durationLabel.frame.maxY + 100, width: 300, height: 40))
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        applyButton.backgroundColor = .purple
        //        UIColor(red:0.33, green:0.77, blue:0.77, alpha:1.0)
        applyButton.layer.borderWidth = 0
        applyButton.layer.cornerRadius = applyButton.frame.height/4
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.addTarget(self, action: #selector(goBackToMain), for: .touchUpInside)

        view.addSubview(applyButton)
        
        //        func sliderValueDidChange(sender: UISlider!) {
        //            let currentValue = Int(sender.value)
        //            thresholdValue = currentValue
        //            print(thresholdValue)
        //        }
        
        //        func sliderValueDidChange(sender: UISlider!)
        //        {
        //            print("Threshold Value: \(sender.value)")
        //            thresholdLabel.text = "\(sender.value)"
        //        }
        
        //        func valueChangeEnded(slider: UISlider) {
        //          print("save to user defaults")
        //            UserDefaults.standard.set(slider.value, forKey: "slider_value")
        //            print(thresholdValue)
        //        }
        //
        //        thresholdValue = Int(UserDefaults.standard.float(forKey: "slider_value"))
        //        print("FINAL")
        //        print(thresholdValue)
        
        
        
        
        
    }
    
    @objc func goBackToMain() {
        performSegue(withIdentifier: "toMain", sender: self)
        
    }
    
    
    
}
