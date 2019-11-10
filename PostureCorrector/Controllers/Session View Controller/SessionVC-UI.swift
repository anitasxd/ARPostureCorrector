//
//  SessionVC-UI.swift
//  PostureCorrector
//
//  Created by Neha Nagabothu on 11/9/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

extension SessionViewController{
    func uiSetup() {

        
        
//        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: gradientScaleImage.frame.minY - 250, width: 200, height: 60))
        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: 25, width: 200, height: 60))
        titleLabel.text = "my stats"
        titleLabel.font = .boldSystemFont(ofSize: 35)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        gradientScaleImage  =  UIImageView(frame: CGRect(x: 200, y: 25, width: 200, height: 60))
        gradientScaleImage.contentMode = .center
        gradientScaleImage.contentMode = .scaleAspectFit
//        gradientScaleImage.center = self.view.center
        gradientScaleImage.clipsToBounds = true
        //        gradientScaleImage.image = UIImage(named: "gradientScale")
        gradientScaleImage.image = UIImage(named: "Group 1")
        view.addSubview(gradientScaleImage)
    }
}
