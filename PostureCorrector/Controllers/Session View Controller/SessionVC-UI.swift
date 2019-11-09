//
//  SessionVC-UI.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController{
    func collectionViewSetup() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.sessionCollection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.sessionCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        self.sessionCollection.backgroundColor = .white
        sessionCollection.dataSource = self as! UICollectionViewDataSource
        sessionCollection.delegate = self as! UICollectionViewDelegate
        self.view.addSubview(sessionCollection)
    }
    
    
}
