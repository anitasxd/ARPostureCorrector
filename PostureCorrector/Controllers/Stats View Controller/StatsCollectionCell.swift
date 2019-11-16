//
//  SessionCollectionCell.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import UIKit

class StatisticsCollectionCell: UICollectionViewCell {
    
    var cellColor : UIColor!
    var colorButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.purple1
        colorButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        colorButton.contentMode = .scaleAspectFit
        colorButton.backgroundColor = cellColor
        colorButton.clipsToBounds = true
        contentView.addSubview(colorButton)
    }
    
}
