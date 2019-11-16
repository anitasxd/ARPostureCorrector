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
        return sessionArray.count // need to change to how many sessions
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 , height: collectionView.frame.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionCell", for: indexPath) as! StatisticsCollectionCell
        cell.awakeFromNib()
        var currSession = sessionArray[indexPath.item]
        var score = Double(currSession.badPostureCount / currSession.postureCount) //currSession.value(forKeyPath: "postureScore") as? Double
        if score > 0.0 && score <= 0.25 {
            cell.cellColor = UIColor.purple1
        } else if score > 0.25 && score <= 0.5 {
            cell.cellColor = UIColor.purple2
        } else if score > 0.5 && score <= 0.75{
            cell.cellColor = UIColor.purple3
        } else {
            cell.cellColor = UIColor.purple4
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


