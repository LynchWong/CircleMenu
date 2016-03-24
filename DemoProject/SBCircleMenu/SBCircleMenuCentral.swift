//
//  SBCircleMenuCentral.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/25/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

public class SBCircleMenuCentral: UIView {
    
    public class func initMenuCentral() -> SBCircleMenuCentral? {
        guard let menuCentral = NSBundle.mainBundle().loadNibNamed("SBCircleMenuCentral", owner: self, options: nil).first as? SBCircleMenuCentral else {
            print("SBCircleMenuCentral 创建失败！")
            return nil
        }
        return menuCentral
    }
    
    public var tapAction: SBMenuItemAction?
    public var continueType: SBMenuItemType! {
        didSet {
            centralLabel.text = continueType.itemsConfig().enLabelText
        }
    }
    
    @IBOutlet weak var botProgressRing: SBProgressRing!
    @IBOutlet weak var topProgressRing: SBProgressRing!
    
    @IBOutlet weak var centralLabel: UILabel!
    
    @IBOutlet weak var centralCircles: UIView!
    @IBOutlet weak var botCircle: UIView!
    @IBOutlet weak var midCircle: UIView!
    @IBOutlet weak var topCircle: UIView!

    public override func awakeFromNib() {
        super.awakeFromNib()
        
        bounds = CGRect(x: 0, y: 0, width: 140, height: 140)
        
        topProgressRing.ringColor = UIColor(red: 130.0/255.0, green: 206.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        botProgressRing.progress = 1.0
        
        centralCircles.layer.cornerRadius = 57
        botCircle.layer.cornerRadius = 57
        midCircle.layer.cornerRadius = 55
        topCircle.layer.cornerRadius = 50
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction:"))
    }
    
    func tapAction(tapGesture: UITapGestureRecognizer) {
        guard let action = tapAction else {
            print("没有定义SBMenuItemAction！")
            return
        }
        action(continueType)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
