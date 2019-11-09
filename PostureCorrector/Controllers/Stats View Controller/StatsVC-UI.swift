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
        gradientScaleImage  =  UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 1.3))
        gradientScaleImage.contentMode = .center
        //gradientScaleImage.contentMode = .scaleAspectFit
        gradientScaleImage.center = self.view.center
        gradientScaleImage.clipsToBounds = true
        gradientScaleImage.image = UIImage(named: "gradientScale")
        view.addSubview(gradientScaleImage)
        
        
        titleLabel = UILabel(frame: CGRect(x: 10, y: gradientScaleImage.frame.maxY + 20, width: view.frame.width, height: 60))
        titleLabel.text = "my stats"
        titleLabel.font = .boldSystemFont(ofSize: 35)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
    }
    
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 100, left: 20, bottom: 20, right: 20)
        self.sessionCollection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.sessionCollection.register(StatisticsCollectionCell.self, forCellWithReuseIdentifier: "sessionCell")
        self.sessionCollection.backgroundColor = UIColor.background
        sessionCollection.dataSource = self as UICollectionViewDataSource
        sessionCollection.delegate = self as UICollectionViewDelegate
        self.view.addSubview(sessionCollection)
    }
    
    
}
