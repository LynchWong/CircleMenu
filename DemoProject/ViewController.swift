//
//  ViewController.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/25/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var circleMenu: SBCircleMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        circleMenu = SBCircleMenu(superView: view, menuItemAction: { [unowned self] (menuItemType: SBMenuItemType) -> () in
            self.gotoView(menuItemType)
        })
        circleMenu.continueType = SBMenuItemType.Listen
        
        NSThread.sleepForTimeInterval(1)
        circleMenu.showWithAnimate()
    }
    
    func gotoView(menuItemType: SBMenuItemType) {
        switch menuItemType {
            case .Film:
                print("Film")
            case .Keyword:
                print("Keyword")
            case .Listen:
                print("Listen")
            case .RolePlay:
                print("RolePlay")
            case .OneOneClass:
                print("OneOneClass")
            case .VideoClass:
                print("VideoClass")
            case .TryShare:
                print("TryShare")
            case .AllStepsDone:
                print("AllStepsDone")
        }
    }

}

