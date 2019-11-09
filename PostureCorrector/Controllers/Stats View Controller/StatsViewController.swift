//
//  SessionViewController.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

class StatisticsViewController: UIViewController {
    var sessionArray = [Session]()
    var currSession : Session!
    
    var gradientScaleImage: UIImageView!
    var titleLabel: UILabel!
    var sessionCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "my stats"
        
        view.backgroundColor = UIColor.background
        collectionViewSetup()
        //uiSetup()
    
    }
    
    
}

