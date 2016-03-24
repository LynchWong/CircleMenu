//
//  SBCircleMenuViewController.swift
//  DemoProject
//
//  Created by Lynch Wong on 2/29/16.
//  Copyright © 2016 Lynch Wong. All rights reserved.
//

import UIKit

class SBCircleMenuViewController: UIViewController {
    
    var circleMenu: SBCircleMenu!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            print("file Film 情景剧")
        case .Keyword:
            print("Key Words 关键词")
        case .Listen:
            print("Listen 听对话")
        case .RolePlay:
            print("Role Play 角色扮演")
        case .OneOneClass:
            print("1 on 1 Class 真人外教课")
        case .VideoClass:
            print("Video Class 讲解视频")
        case .TryShare:
            print("Try&Share 配音秀")
        case .AllStepsDone:
            print("Complete")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
