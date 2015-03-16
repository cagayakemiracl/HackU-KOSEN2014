//
//  nextView.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/13.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.


import Foundation
import UIKit

class nextView:UIViewController {
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
        ////////
        var label:UILabel = UILabel()
        label.frame = CGRectMake(50, 100, 100, 100)
        label.text = "コードから来ました"
        label.sizeToFit()
        self.view.addSubview(label)
    }
    
    
    func leftButtonTouch() {
        self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
    }
}

///////////////////////////////////////////////////////


class ViewController1: UIViewController {
    var button: UIButton!
    override func viewDidLoad() {
    super.viewDidLoad()
    let normalImage = UIImage(named: "NormalBlueButton")
    let highlightedImage = UIImage(named: "HighlightedBlueButton")
    button = UIButton.buttonWithType(.Custom) as? UIButton
    button.frame = CGRect(x: 110, y: 70, width: 100, height: 44)
    button.setTitle("Normal", forState: .Normal)
    button.setTitle("Pressed", forState: .Highlighted)
    button.setBackgroundImage(normalImage, forState: .Normal)
    button.setBackgroundImage(highlightedImage, forState: .Highlighted)
    view.addSubview(button)
    }
}
///////////////////////////////////////////////////////


import UIKit
class ViewController: UIViewController {
        func performAdd(sender: UIBarButtonItem){
            println("Add method got called")
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Add",
                style: .Plain,
                target: self,
                action: "performAdd:")
        }
}

///////////////////////////////////////////////////////