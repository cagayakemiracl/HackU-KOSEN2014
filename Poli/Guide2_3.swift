//
//  Guide2_3.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/14.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

import Foundation
import UIKit

class GuideView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////
        var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(0, 0, 50, 35)
        button.setTitle("Menu", forState: UIControlState.Normal)
        button.setTitleColor(UIColor(red:0.3, green:0.69, blue:0.75, alpha:1), forState: UIControlState.Normal)
        button.addTarget(self, action: "leftButtonTouch", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        self.airSwipeHandler = {() -> Void in
            self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
            return
        }
        func leftButtonTouch() {
            self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
        }
        ////////
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
