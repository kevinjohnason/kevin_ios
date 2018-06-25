//
//  GradientSubtitleTableViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/21/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class GradientSubtitleTableViewCell: SubtitleTableViewCell {
    
    let gradient = CAGradientLayer()
    
    @IBInspectable var fromColor: UIColor = UIColor.white
    
    @IBInspectable var toColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradient.colors = [fromColor.cgColor, toColor.cgColor]
        self.contentView.layer.insertSublayer(gradient, at: 0)
    }
            
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }
}
