//
//  RoundViews.swift
//  kevin
//
//  Created by kevin.cheng on 6/20/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    
    @IBInspectable var borderColor: UIColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    fileprivate func setup() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}

@IBDesignable
class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
    
    func setup() {
        layer.cornerRadius = frame.size.width / 2
        self.clipsToBounds = true
    }
    
}

@IBDesignable
class RoundLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 0
    
    convenience init(cornerRadius: CGFloat) {
        self.init(frame: CGRect.zero)
        self.cornerRadius = cornerRadius
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    fileprivate func setup() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}

@IBDesignable
class RoundView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var roundTopLeftCorner: Bool  = true
    @IBInspectable var roundTopRightCorner: Bool  = true
    @IBInspectable var roundBottomLeftCorner: Bool  = true
    @IBInspectable var roundBottomRightCorner: Bool  = true
    @IBInspectable var bottomBorderWidth: CGFloat = 0
    @IBInspectable var bottomBorderColor: UIColor = UIColor.clear
    @IBInspectable var borderColor: UIColor = UIColor.clear
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var hasShadow: Bool = false
    let bottomLayer: CALayer = CALayer()    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLayer.position = CGPoint(x: 0, y: bounds.size.height - bottomBorderWidth)
    }
    
    fileprivate func setup() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        var cornerMask = CACornerMask()
        if roundTopLeftCorner {
            cornerMask.insert(CACornerMask.layerMinXMinYCorner)
        }
        if roundTopRightCorner {
            cornerMask.insert(CACornerMask.layerMaxXMinYCorner)
        }
        if roundBottomLeftCorner {
            cornerMask.insert(CACornerMask.layerMinXMaxYCorner)
        }
        if roundBottomRightCorner {
            cornerMask.insert(CACornerMask.layerMaxXMaxYCorner)
        }
        layer.maskedCorners = cornerMask
        bottomLayer.backgroundColor = bottomBorderColor.cgColor
        bottomLayer.frame = CGRect(x: 0, y: bounds.size.height - bottomBorderWidth, width: bounds.size.width, height: bottomBorderWidth)
        layer.addSublayer(bottomLayer)
        if hasShadow {
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.05
            layer.shadowRadius = 3
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
        
    }
}

@IBDesignable
class CircularView: UIView {
    
    @IBInspectable var bottomBorderWidth: CGFloat = 0
    @IBInspectable var bottomBorderColor: UIColor = UIColor.clear
    
    let bottomLayer: CALayer = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLayer.position = CGPoint(x: 0, y: bounds.size.height - bottomBorderWidth)
        layer.cornerRadius = self.frame.height / 2
    }
    
    fileprivate func setup() {
        clipsToBounds = true
        bottomLayer.backgroundColor = bottomBorderColor.cgColor
        bottomLayer.frame = CGRect(x: 0, y: bounds.size.height - bottomBorderWidth, width: bounds.size.width, height: bottomBorderWidth)
        layer.addSublayer(bottomLayer)
    }
}

class CircularLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
    
    fileprivate func setup() {
        clipsToBounds = true
    }
}
