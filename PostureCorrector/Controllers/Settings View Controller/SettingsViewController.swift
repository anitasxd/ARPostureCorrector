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
    var thresholdValueLabel: UILabel!
    
    var durationSlider: UISlider!
    var durationLabel: UILabel!
    var durationValueLabel: UILabel!
    
    var thresholdValue: Float = 1
    var durationValue: Float = 1
    
    var applyButton: UIButton!
    let step: Float=0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.purple3

        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        thresholdSlider.setValue(UserDefaults.standard.float(forKey: "thresholdValue"), animated: false)
        durationSlider.setValue(UserDefaults.standard.float(forKey: "durationValue"), animated: false)
    }
    
    func setupLayout() {
        view.backgroundColor = UIColor.background
        
        screenTitle = UILabel(frame: CGRect(x: 30, y: (navigationController?.navigationBar.frame.height ?? 20) + 35, width: view.frame.width-60, height: 60))
        screenTitle.font = .boldSystemFont(ofSize: 50)
        screenTitle.textColor = .white
        screenTitle.textAlignment = .center
        screenTitle.center.x = self.view.center.x
        screenTitle.text = "settings"
        view.addSubview(screenTitle)
        
        thresholdSlider = UISlider(frame: CGRect(x: 3 * (view.frame.width/8), y: 200, width: 150, height: 30))
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
        
        thresholdValueLabel = UILabel(frame: CGRect(x: thresholdSlider.frame.maxX + 10, y: 190, width: view.frame.width-60, height: 60))
        thresholdValueLabel.font = .boldSystemFont(ofSize: 18)
        thresholdValueLabel.textColor = .white
        thresholdValueLabel.text = "\(thresholdValue * 100)%"
        //        thresholdLabel.text = "\(thresholdSlider.value)"
        view.addSubview(thresholdValueLabel)
        
        //        thresholdValue = Int(thresholdSlider.value)
        
        durationSlider = UISlider(frame: CGRect(x: 3 * (view.frame.width/8), y: 300, width: 150, height: 30))
        durationSlider.addTarget(self, action: #selector(sliderValueDidChange2), for: .valueChanged)
        //        self.durationSlider.value = durationValue
        durationSlider.setValue(durationValue, animated: false)
        view.addSubview(durationSlider)
        
        durationLabel = UILabel(frame: CGRect(x: 20, y: 290, width: view.frame.width-60, height: 60))
        durationLabel.font = .boldSystemFont(ofSize: 22)
        durationLabel.textColor = .white
        durationLabel.text = "sensitivity"
        view.addSubview(durationLabel)
        
        durationValueLabel = UILabel(frame: CGRect(x: durationSlider.frame.maxX, y: 290, width: view.frame.width-60, height: 60))
        durationValueLabel.font = .boldSystemFont(ofSize: 18)
        durationValueLabel.textColor = .white
        durationValueLabel.text = "\(durationValue * 100)%"
        view.addSubview(durationValueLabel)
        
        
        applyButton = UIButton(frame: CGRect(x: view.frame.width/2 - 150, y: durationLabel.frame.maxY + 100, width: 300, height: 40))
        applyButton.setTitle("Apply", for: .normal)
        applyButton.titleLabel!.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        applyButton.backgroundColor = UIColor.purple3
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
        UserDefaults.standard.set(thresholdValueLabel.text, forKey: "thresholdValue")
        UserDefaults.standard.set(durationSlider.value, forKey: "durationValue")
        UserDefaults.standard.set(durationValueLabel.text, forKey: "durationValue")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let visionPage = segue.destination as? JointViewController{
            visionPage.settingsThreshold = thresholdValue
            visionPage.settingsSensitivity = durationValue
        }

    }
    
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        //        let step: Float = 5
        print("Slider value changed")
        //        thresholdLabel.text = "\(sender.value)"
        
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        thresholdValueLabel.text = "\(roundedStepValue * 100)%"
        
        //        print("Slider step value \(Int(roundedStepValue))")
        //        print("Threshold Value: \(sender.value)")
        //        thresholdLabel.text = "\(sender.value)"
        //        thresholdValue = sender.value
    }
    
    @objc func sliderValueDidChange2(_ sender: UISlider!) {
        print("Slider value changed")
        let roundedStepValue2 = round(sender.value / step) * step
        sender.value = roundedStepValue2
        durationValueLabel.text = "\(roundedStepValue2 * 100)%"
    }
    
    
    
}
