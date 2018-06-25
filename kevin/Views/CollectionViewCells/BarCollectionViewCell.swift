//
//  BarCollectionViewCell.swift
//  kevin
//
//  Created by kevin.cheng on 6/22/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit

class BarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var barView: VerticalBar!
    
    @IBOutlet weak var barTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
