//
//  SessionCollectionCell.swift
//  PostureCorrector
//
//  Created by Anita Shen on 11/2/19.
//  Copyright © 2019 tucan9389. All rights reserved.
//

import UIKit

class StatisticsCollectionCell: UICollectionViewCell {
    
    //var cellColor : UIColor!
    //var colorButton : UIButton!
    var colorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.purple1
        colorImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        colorImage.contentMode = .scaleAspectFit
        //colorButton.backgroundColor = cellColor
        colorImage.clipsToBounds = true
        contentView.addSubview(colorImage)
    }
    
}
