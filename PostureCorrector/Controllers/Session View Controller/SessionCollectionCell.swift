//
//  SessionCollectionCell.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import UIKit

class SessionCollectionCell: UICollectionViewCell {
    
    var color : UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = color
    }
    
}
