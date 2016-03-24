//
//  SBProgressRing.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/25/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

public class SBProgressRing: UIView {
    
    private let ringLayer = CAShapeLayer()
    
    public var progress: CGFloat = 0.0 {
        didSet {
            var p = progress
            if progress < 0 {
                p = CGFloat.min
            }
            if progress > 1 {
                p = 1
            }
            
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
            CATransaction.setAnimationDuration(duration)
            ringLayer.strokeEnd = p
            CATransaction.commit()
        }
    }
    
    public var ringColor = UIColor.redColor() {
        didSet {
            ringLayer.strokeColor = ringColor.CGColor
        }
    }
    
    public var duration: NSTimeInterval = 0.25
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.clearColor()
        clipsToBounds = true
        
        let lineWidth: CGFloat = 7.0
        
        // 使用UIBezierPath创建layer的CGPath
        // 完整的CGPath是整个圆环
        let circlePath = UIBezierPath(arcCenter: layer.position,
            radius: (frame.size.width - lineWidth)/2,
            startAngle: CGFloat(-M_PI_2),//起点从x轴正的部分开始，所以从－90开始
            endAngle: CGFloat(M_PI_2 * 3.0),//起点从x轴正的部分开始，结束为270度。结束 - 开始，270 - (-90)正好是2PI，360度
            clockwise: true)
        
        // 设置CAShapeLayer 的path, colors, 和 lineWidth
        ringLayer.path = circlePath.CGPath
        ringLayer.fillColor = UIColor.clearColor().CGColor
        ringLayer.strokeColor = UIColor(red: 55.0/255.0, green: 160.0/255.0, blue: 244.0/255.0, alpha: 1.0).CGColor
        ringLayer.lineWidth = lineWidth
        ringLayer.lineCap = kCALineCapRound//让path有圆角效果
        
        // 刚开始不绘制圆环
        ringLayer.strokeEnd = CGFloat.min
        
        // 添加到layer
        layer.addSublayer(ringLayer)
    }

}
