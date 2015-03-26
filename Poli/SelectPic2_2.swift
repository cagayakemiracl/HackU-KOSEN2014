//
//  SelectPic2_2.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/14.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

import Foundation
import UIKit

class SelectPic: UIViewController {
    
    
    
    func scrollImageButton(NoI:String,Fx:Int,Fy:Int,Fw:Int,Fh:Int,btnTitle:String,tag:Int) -> UIButton{
        var btn:UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        let SelectImage = UIImage(named:NoI)
        btn.frame = CGRect(x: Fx, y: Fy, width: Fw, height: Fh)
        btn.setTitle(btnTitle, forState: UIControlState.Normal)
        btn.tag = tag
        btn.setBackgroundImage(SelectImage, forState: .Normal)
        btn.addTarget(nil, action:"switchTag:",forControlEvents: .TouchUpInside)
        return btn
    }
    
    var ScrollViews = ["Cute","Sexy","Lovely","Cool"]
    var x:Int = 0;
    var y:Int = 190;
    var w:Int = 320;
    var h:Int = 377;
    
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //AppDelegateのインスタンスを取得
        var imageID = appDelegate.imageID
        
        println(imageID)
        
        label = UILabel(frame: CGRectMake(40+17,84,240,60))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.blackColor()
        label.text = ScrollViews[imageID!]
        label.font = UIFont.boldSystemFontOfSize(66)
        view.addSubview(label)
        
       // scrollView.frame = CGRect(x: x,y: y,width: w,height: h)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
