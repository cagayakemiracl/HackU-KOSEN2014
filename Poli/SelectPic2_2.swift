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
    
    
    var Fx:Int = 0;
    var Fy:Int = 190;
    var Fw:Int = 320;
    var Fh:Int = 377;
    
    var imageView: UIImageView!
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRectMake(40+17,84,240,60))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = ["Cute","Sexy","Lovely","Cool"][0]
        label.font = UIFont.boldSystemFontOfSize(66)
        view.addSubview(label)
        
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0,190,320,377)
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
        var imgs = appDelegate.ScrollViews
        //var imgs = [String]()
        
        //imgsの個数を数える
        
        
        //imgsの個数にしたがって全体の大きさを決める
        scrollView.contentSize = CGSizeMake(240*4, 300)
        
        //ぺたぺた貼っていく
        for img in imgs{
            
        }
        
        
        
        
        self.view.addSubview(scrollView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

