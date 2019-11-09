//
//  SearchViewController.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    var sessionArray = [Session]()
    var currSession : Session!
    
    var sessionLabel: UILabel!
    var sessionCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sessions"
        collectionViewSetup()
    
    }
    
    
}

