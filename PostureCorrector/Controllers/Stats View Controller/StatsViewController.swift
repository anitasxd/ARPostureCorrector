//
//  SessionViewController.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StatisticsViewController: UIViewController {
    //var sessionArray = UserData.userSessions
    var currSession : Session!
    
    var gradientScaleImage: UIImageView!
    var titleLabel: UILabel!
    //var backButton: UIButton!
    
    var sessionCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.barTintColor = UIColor.background
        view.backgroundColor = UIColor.background
        navigationController?.navigationBar.barTintColor = UIColor.purple3
        collectionViewSetup()
        uiSetup()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Sessions")
        
        do {
            UserData.userSessions = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
}

