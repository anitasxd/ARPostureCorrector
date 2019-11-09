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
    
    var durationSlider: UISlider!
    var durationLabel: UILabel!
    
    var thresholdValue: Float = 1
    var durationValue: Float = 1
    
    var applyButton: UIButton!
    let step: Float=0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        thresholdSlider.setValue(UserDefaults.standard.float(forKey: "thresholdValue"), animated: false)
        durationSlider.setValue(UserDefaults.standard.float(forKey: "durationValue"), animated: false)
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
        thresholdSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        //        self.thresholdSlider.value = thresholdValue
        thresholdSlider.setValue(thresholdValue, animated: false)
        view.addSubview(thresholdSlider)
        
        thresholdLabel = UILabel(frame: CGRect(x: 20, y: 190, width: view.frame.width-60, height: 60))
        thresholdLabel.font = .boldSystemFont(ofSize: 22)
        thresholdLabel.textColor = .white
        thresholdLabel.text = "threshold"
        //        thresholdLabel.text = "\(thresholdSlider.value)"
        view.addSubview(thresholdLabel)
        
        //        thresholdValue = Int(thresholdSlider.value)
        
        durationSlider = UISlider(frame: CGRect(x: 3 * (view.frame.width/7), y: 300, width: 150, height: 30))
        durationSlider.addTarget(self, action: #selector(sliderValueDidChange2), for: .valueChanged)
        //        self.durationSlider.value = durationValue
        durationSlider.setValue(durationValue, animated: false)
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
        
    }
    
    @objc func goBackToMain() {
        performSegue(withIdentifier: "toMain", sender: self)
        UserDefaults.standard.set(thresholdSlider.value, forKey: "thresholdValue")
        UserDefaults.standard.set(durationSlider.value, forKey: "durationValue")
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        print("Slider value changed")
        //        thresholdLabel.text = "\(sender.value)"
        
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        print("Slider step value \(Int(roundedStepValue))")
        print("Threshold Value: \(sender.value)")
        //        thresholdLabel.text = "\(sender.value)"
        //        thresholdValue = sender.value
    }
    
    @objc func sliderValueDidChange2(_ sender: UISlider!) {
        print("Slider value changed")
        let roundedStepValue2 = round(sender.value / step) * step
        sender.value = roundedStepValue2
    }
    
    
    
}
