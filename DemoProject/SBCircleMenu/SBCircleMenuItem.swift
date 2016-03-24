//
//  SBCircleMenuItem.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/25/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

let offset = CGPoint(x: 43.0, y: 62.0)//中心点距离origin的x, y距离

let radius: CGFloat = 35.0//外圆圈的半径

public typealias SBMenuItemAction = (SBMenuItemType) -> ()

public class SBCircleMenuItem: UIView {
    
    public class func initMenuItem() -> SBCircleMenuItem? {
        guard let menuItem = NSBundle.mainBundle().loadNibNamed("SBCircleMenuItem", owner: self, options: nil).first as? SBCircleMenuItem else {
            print("SBCircleMenuItem 创建失败！")
            return nil
        }
        return menuItem
    }
    
    public var menuItemType: SBMenuItemType! {
        didSet {
            guard let superView = superview else {
                print("superview 不存在！")
                return
            }
            
            //计算角度
            let angle = menuItemType.itemAngle()
            
            //设置frame
            let centerPoint = superView.center//父视图的中心点
            //SBCircleMenuItem的中心点
            let center = CGPoint(x: centerPoint.x + circleDistance * CGFloat(cosf(Float(angle - M_PI_2))),
                                 y: centerPoint.y + circleDistance * CGFloat(sinf(Float(angle - M_PI_2))))
            
//            let view = UIView(frame: CGRect(origin: center, size: CGSize(width: 2, height: 2)))
//            view.backgroundColor = UIColor.yellowColor()
//            superView.addSubview(view)
            
            //计算按钮的origin
            let origin = CGPoint(x: center.x - offset.x,
                                 y: center.y - offset.y)
            frame = CGRect(origin: origin, size: bounds.size)//设置frame
            
            //设置按钮序号
            nuLabel.text = "\(menuItemType.rawValue)"
            
            //设置标签内容
            enLabel.text = menuItemType.itemsConfig().enLabelText
            chLabel.text = menuItemType.itemsConfig().chLabelText
            
            //设置按钮图片
            guard let image = UIImage(named: menuItemType.itemsConfig().imageName) else {
                print("menuItemType.typeImageName() 创建的图片不存在")
                return
            }
            typeImageView.image = image
            
            //设置按钮序号位置
            centerXConstraint.constant = radius * CGFloat(cosf(Float(angle + M_PI_2)))
            centerYConstraint.constant = radius * CGFloat(sinf(Float(angle + M_PI_2)))
        }
    }
    
    public var menuItemState = SBMenuItemState.Normal {
        didSet {
            switch menuItemState {
                case SBMenuItemState.Normal:
                    insCircleView.backgroundColor = UIColor(red: 78.0/255.0, green: 84.0/255.0, blue: 94.0/255.0, alpha: 1.0)
                    numCircleView.backgroundColor = UIColor.whiteColor()
                    nuLabel.textColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
                case SBMenuItemState.Select:
                    insCircleView.backgroundColor = UIColor(red: 78.0/255.0, green: 84.0/255.0, blue: 94.0/255.0, alpha: 1.0)
                    numCircleView.backgroundColor = UIColor(red: 55.0/255.0, green: 160.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                    nuLabel.textColor = UIColor.whiteColor()
                case SBMenuItemState.Complete:
                    insCircleView.backgroundColor = UIColor(red: 55.0/255.0, green: 160.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                    numCircleView.backgroundColor = UIColor.whiteColor()
                    nuLabel.textColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            }
        }
    }
    
    public var menuItemAction: SBMenuItemAction?
    
    @IBOutlet weak var outCircleView: UIView!
    @IBOutlet weak var insCircleView: UIView!
    @IBOutlet weak var numCircleView: UIView!
    
    @IBOutlet weak var typeImageView: UIImageView!
    
    @IBOutlet weak var nuLabel: UILabel!
    @IBOutlet weak var enLabel: UILabel!
    @IBOutlet weak var chLabel: UILabel!
    
    @IBOutlet weak var centerXConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        bounds = CGRect(x: 0, y: 0, width: 86, height: 124)
        
        outCircleView.layer.cornerRadius = 35
        insCircleView.layer.cornerRadius = 30
        numCircleView.layer.cornerRadius = 8
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction:"))
    }
    
    func tapAction(tapGesture: UITapGestureRecognizer) {
        guard let action = menuItemAction else {
            print("没有定义SBMenuItemAction！")
            return
        }
        action(menuItemType)
    }

}
