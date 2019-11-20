//
//  SessionVC-Collection.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import Foundation
import UIKit

extension StatisticsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserData.userSessions.count // need to change to how many sessions
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 , height: collectionView.frame.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionCell", for: indexPath) as! StatisticsCollectionCell
        cell.awakeFromNib()
        let currSession = UserData.userSessions[indexPath.item]
        let BPostureCount = currSession.value(forKeyPath: "badPostureCount") as? Double
        let TPostureCount = currSession.value(forKeyPath: "totalPostureCount") as? Double
        let cellScore = BPostureCount! / TPostureCount!
        //Double(currSession.badPostureCount) / Double(currSession.postureCount)
        print(cellScore)
        if cellScore > 0.0 && cellScore <= 0.25 {
            cell.colorImage.image = UIImage(named: "purple1")
        } else if cellScore > 0.25 && cellScore <= 0.5 {
            cell.colorImage.image = UIImage(named: "purple2")
        } else if cellScore > 0.5 && cellScore <= 0.75{
            cell.colorImage.image = UIImage(named: "purple3")
        } else {
            cell.colorImage.image = UIImage(named: "purple4")
        }
        return cell
//        if score! > 0.0 && score! <= 0.25 {
//            cell.backgroundColor = UIColor.purple1
//        } else if score! > 0.25 && score! <= 0.5{
//            cell.color = UI
//        }
        
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        profilePokemon = favoritePokemon[indexPath.row]
//        UserDefaults.standard.set(favoritePokemon, forKey: "favorites")
//        self.performSegue(withIdentifier: "toProfile", sender: self)
//    }
//

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if let profile = segue.destination as? ProfileViewController{
//            profile.selectedPokemon = profilePokemon
//        }
//    }
    
    
    
}


