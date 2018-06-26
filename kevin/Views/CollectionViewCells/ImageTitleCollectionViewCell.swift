//
//  ImagetTitleCollectionViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/25/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class ImageTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupRoundShadow()
    }
    
    func setupRoundShadow() {
        backgroundColor = UIColor.clear
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 3
        layer.masksToBounds = false
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.backgroundColor = UIColor.white
    }

}
