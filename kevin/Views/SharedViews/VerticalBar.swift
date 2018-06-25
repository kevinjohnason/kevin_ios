//
//  VerticalBar.swift
//  kevin
//
//  Created by kevin.cheng on 6/22/18.
//  Copyright © 2018 Nazca Triangle. All rights reserved.
//

import UIKit
@IBDesignable
class VerticalBar: UIView {
    
    @IBInspectable var chartOverlayColor: UIColor = UIColor.clear
    
    @IBInspectable var chartColor: UIColor = UIColor.black
    
    @IBInspectable var initialAnimateDuration: TimeInterval = 1
    
    private var _chartValue: Float = 0
    //0 ~ 1
    @IBInspectable var chartValue: Float {
        get {
            return _chartValue
        }
        set {
            if newValue > 1 {
                _chartValue = 1
            } else if newValue < 0 {
                _chartValue = 0
            } else {
                _chartValue = newValue
            }
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var padding: CGFloat = 0.5
    
    var displayText: String = ""
    
    lazy var circleLayer: CAShapeLayer = {
        let cLayer = CAShapeLayer()
        self.layer.addSublayer(cLayer)
        cLayer.fillColor = self.chartColor.cgColor
        return cLayer
    }()
    
    lazy var overlayLayer: CAShapeLayer = {
        let cLayer = CAShapeLayer()
        self.layer.addSublayer(cLayer)
        cLayer.fillColor = self.chartOverlayColor.cgColor
        return cLayer
    }()
    
    lazy var textLayer: CATextLayer = {
        let tLayer = CATextLayer()
        tLayer.fontSize = 10
        tLayer.alignmentMode = kCAAlignmentCenter
        tLayer.foregroundColor = UIColor(red: 53.0/255, green: 54.0/255, blue: 52.0/255, alpha: 1).cgColor
        self.layer.addSublayer(tLayer)
        return tLayer
    }()
    
    var circleY: CGFloat {
        return  (self.bounds.height - radius * 1.5) * (1 - CGFloat(chartValue) * 0.85)
    }
    
    var radius: CGFloat {
        return self.bounds.width / 2
    }
    
    var chartWidth: CGFloat {
        return self.bounds.width / 2
    }
    
    var bottomY: CGFloat {
        return self.bounds.height - radius
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let originalOverlayRect = CGRect(x: padding + chartWidth / 2,
                                         y: bottomY, width: chartWidth - padding * 2, height: 0)
        let originalOverlayPath = UIBezierPath(rect: originalOverlayRect)
        let overlayDestinationRect = CGRect(x: padding + chartWidth / 2,
                                            y: circleY + chartWidth / 2, width:
            chartWidth - padding * 2, height: self.bounds.height - circleY - radius - chartWidth / 2)
        let overlayPath = UIBezierPath(rect: overlayDestinationRect)
        overlayLayer.path = originalOverlayPath.cgPath
        var animation = CABasicAnimation(keyPath: "path")
        animation.toValue = overlayPath.cgPath
        animation.duration = initialAnimateDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        overlayLayer.add(animation, forKey: nil)
        drawBottom()
        let circleOriginalRect = CGRect(x: chartWidth / 2, y: bottomY - (chartWidth / 2 - padding * 2), width: chartWidth, height: chartWidth)
        let originalCirclePath = UIBezierPath(ovalIn: circleOriginalRect)
        circleLayer.path = originalCirclePath.cgPath
        
        let circleDestinationRect = CGRect(x: chartWidth / 2, y: circleY, width: chartWidth, height: chartWidth)
        animation = CABasicAnimation(keyPath: "path")
        animation.toValue = UIBezierPath(ovalIn: circleDestinationRect).cgPath
        animation.duration = initialAnimateDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        circleLayer.add(animation, forKey: nil)
        textLayer.frame = CGRect(x: 0, y: bottomY - (chartWidth / 2 - padding * 2) - 10,
                                 width: self.bounds.size.width, height: 15)
        textLayer.string = self.displayText
        let textAnimation = CABasicAnimation(keyPath: "position.y")
        textAnimation.duration = initialAnimateDuration
        textAnimation.toValue = self.circleY - 10
        textAnimation.isRemovedOnCompletion = false
        textAnimation.fillMode = kCAFillModeForwards
        textLayer.add(textAnimation, forKey: nil)
    }
    
    func drawBottom() {
        let overlayHeadPath = UIBezierPath(arcCenter: CGPoint(x: chartWidth, y: bottomY),
                                           radius: chartWidth / 2 - padding * 2, startAngle: 0, endAngle: -1 * CGFloat.pi, clockwise: true)
        chartOverlayColor.setFill()
        overlayHeadPath.fill()
        overlayHeadPath.close()
    }
}
