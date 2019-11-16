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

        
        
//        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: gradientScaleImage.frame.minY - 250, width: 200, height: 60))
        titleLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 100, y: 25, width: 200, height: 60))
        titleLabel.text = "my stats"
        titleLabel.font = .boldSystemFont(ofSize: 35)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        
        gradientScaleImage  =  UIImageView(frame: CGRect(x:view.frame.width/2 - 100, y: titleLabel.frame.maxY, width: 200, height: 50))
        gradientScaleImage.contentMode = .center
        gradientScaleImage.contentMode = .scaleAspectFit
//        gradientScaleImage.center = self.view.center
        gradientScaleImage.clipsToBounds = true
        //        gradientScaleImage.image = UIImage(named: "gradientScale")
        gradientScaleImage.image = UIImage(named: "Group 1")
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
    
    
}
