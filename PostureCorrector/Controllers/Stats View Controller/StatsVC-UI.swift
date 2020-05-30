//
//  SessionVC-UI.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

extension StatisticsViewController{
    func uiSetup() {
//        backButton = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
//        backButton.contentMode = .scaleAspectFit
//        backButton.clipsToBounds = true
//        //backButton.backgroundColor = cellColor
//        backButton.setImage(UIImage(named: "backButton"), for: .normal)
//        backButton.addTarget(self, action: #selector(backToMain), for: .touchUpInside)
//        view.addSubview(backButton)
        
//        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: gradientScaleImage.frame.minY - 250, width: 200, height: 60))
        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: (navigationController?.navigationBar.frame.height ?? 20) + 35, width: 200, height: 60))
        titleLabel.text = "my stats"
        titleLabel.font = .boldSystemFont(ofSize: 50)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        gradientScaleImage  =  UIImageView(frame: CGRect(x:view.frame.width/2 - 100, y: titleLabel.frame.maxY, width: 200, height: 50))
        gradientScaleImage.contentMode = .center
        gradientScaleImage.contentMode = .scaleAspectFit
//        gradientScaleImage.center = self.view.center
        gradientScaleImage.clipsToBounds = true
        //        gradientScaleImage.image = UIImage(named: "gradientScale")
        gradientScaleImage.image = UIImage(named: "postureGradient")
        view.addSubview(gradientScaleImage)
    }
    
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 150, left: 20, bottom: 20, right: 20)
        self.sessionCollection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.sessionCollection.register(StatisticsCollectionCell.self, forCellWithReuseIdentifier: "sessionCell")
        self.sessionCollection.backgroundColor = UIColor.background
        sessionCollection.dataSource = self as UICollectionViewDataSource
        sessionCollection.delegate = self as UICollectionViewDelegate
        self.view.addSubview(sessionCollection)
    }
    
//    @objc func backToMain(sender: UIButton) {
//        performSegue(withIdentifier: "statsToMain", sender: self)
//    }
    
    
}
