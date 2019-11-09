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
        return 12 // need to change to how many sessions
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 , height: collectionView.frame.width / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sessionCell", for: indexPath) as! StatisticsCollectionCell
        cell.awakeFromNib()
        cell.color = UIColor.purple2
        return cell
        
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


