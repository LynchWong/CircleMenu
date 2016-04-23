//
//  SBCircleMenu.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/26/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import Foundation
import UIKit

let circleDistance: CGFloat = 150.0

public enum SBMenuItemType: Int {
    
    case Film = 1//标识按钮的类型，同时标识用户当前应该继续的步骤
    case Keyword
    case Listen
    case RolePlay
    case OneOneClass
    case VideoClass
    case TryShare
    
    case AllStepsDone //不标识按钮的类型，用来标识用户的所有步骤都完成
    
    public func itemsConfig() -> (imageName: String, enLabelText: String, chLabelText: String) {
        switch self {
            case .Film:
                return ("keyword", "Key Words", "关键词")
            case .Keyword:
                return ("keyword", "Key Words", "关键词")
            case .Listen:
                return ("keyword", "Key Words", "关键词")
            case .RolePlay:
                return ("keyword", "Key Words", "关键词")
            case .OneOneClass:
                return ("keyword", "Key Words", "关键词")
            case .VideoClass:
                return ("keyword", "Key Words", "关键词")
            case .TryShare:
                return ("keyword", "Key Words", "关键词")
            case .AllStepsDone: //没有对应的按钮
                return ("", "", "")
        }
    }
    
    public static func totalMenuItemsNum() -> Int {
        return SBMenuItemType.TryShare.rawValue
    }
    
//    public static func totalStepsNum() -> Int {
//        return SBMenuItemType.AllStepsDone.rawValue
//    }
    
    public func itemAngle() -> Double {
        return M_PI * 2 / Double(SBMenuItemType.totalMenuItemsNum()) * Double(rawValue - 1)
    }
}

public enum SBMenuItemState {
    case Normal
    case Select
    case Complete
}

public class SBCircleMenu {
    
    var menuItems: [SBCircleMenuItem] = []
    var menuCentral: SBCircleMenuCentral!
    var superview: UIView
    
    var continueType = SBMenuItemType.Film {
        didSet {
            menuCentral.continueType = continueType
            for i in 1...SBMenuItemType.totalMenuItemsNum() {
                let menuItem = menuItems[i - 1]
                if continueType == SBMenuItemType.AllStepsDone {
                    menuItem.menuItemState = SBMenuItemState.Complete
                } else {
                    if i < continueType.rawValue {
                        menuItem.menuItemState = SBMenuItemState.Complete
                    } else if i == continueType.rawValue {
                        menuItem.menuItemState = SBMenuItemState.Select
                    } else {
                        menuItem.menuItemState = SBMenuItemState.Normal
                    }
                }
            }
        }
    }
    
    public init(superView: UIView, menuItemAction: SBMenuItemAction) {
        
        superview = superView
        guard let menuCentral = SBCircleMenuCentral.initMenuCentral() else {
            print("创建 SBCircleMenuCentral 失败！")
            return
        }
        menuCentral.center = superView.center
        menuCentral.alpha = 0.0
        menuCentral.tapAction = menuItemAction
        superView.addSubview(menuCentral)
        self.menuCentral = menuCentral
        
        for i in 1...SBMenuItemType.totalMenuItemsNum() {
            guard let menuItemType = SBMenuItemType(rawValue: i) else {
                print("创建SBMenuItemType失败，没有这种类型！")
                return
            }
            guard let menuItem = SBCircleMenuItem.initMenuItem() else {
                print("创建SBCircleMenuItem失败！")
                return
            }
            menuItem.menuItemAction = menuItemAction
            menuItem.alpha = 0.0
            superView.addSubview(menuItem)
            menuItem.menuItemType = menuItemType
            menuItems.append(menuItem)
        }
    }
    
    public func showWithAnimate() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.menuCentral.alpha = 1.0
            }) { (finish: Bool) -> Void in
                for var i = 0; i < self.menuItems.count; i++ {
                    let menuItem = self.menuItems[i]
                    menuItem.transform = CGAffineTransformMakeScale(0.01, 0.01)
                    UIView.animateWithDuration(0.1, delay: 0.1 * Double(i), options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                            menuItem.alpha = 1.0
                            menuItem.transform = CGAffineTransformMakeScale(1.1, 1.1)
                        }, completion: { (finish: Bool) -> Void in
                            UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                                    menuItem.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                }, completion: { (finish: Bool) -> Void in
                                    
                            })
                    })
                }
                self.menuCentral.topProgressRing.duration = 0.7
                self.menuCentral.topProgressRing.progress = CGFloat(self.continueType.itemAngle() / (M_PI * 2))
        }
    }
    
}
