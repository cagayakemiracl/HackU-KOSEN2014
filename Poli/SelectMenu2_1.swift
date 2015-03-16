
//
//  SelectMenu2_1.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/14.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

import UIKit





class SelectMenuController: UIViewController {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRectMake(40+17,84,240,60))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Select Menu"
        label.font = UIFont.boldSystemFontOfSize(66)
        view.addSubview(label)
        
        var button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        
        button.frame = CGRectMake(0, 0, 50, 35)
        
        button.setTitle("☆Fav", forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor(red:0.3, green:0.69, blue:0.75, alpha:1), forState: UIControlState.Normal)
        
        button.addTarget(self, action: "leftButtonTouch", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        self.airSwipeHandler = {() -> Void in
            self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
            return
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        var x:Int = 0;
        var y:Int = 0;
        var w:Int = 240;
        var h:Int = 300;
        let ButtonCute  = scrollImageButton("cute.jpeg",Fx: x, Fy: y, Fw: w,Fh: h,btnTitle: "cute",tag: 1)
        let ButtonSexy = scrollImageButton("sexy.jpeg",Fx: w,Fy: y,Fw: w,Fh: h,btnTitle:"sexy",tag:2)
        let ButtonLovely = scrollImageButton("lovely.jpeg",Fx: w*2,Fy: y,Fw: w,Fh: h,btnTitle:"lovely",tag:3)
        let ButtonCool  = scrollImageButton("cool.jpeg",Fx: w*3,Fy: y,Fw: w,Fh: h,btnTitle:"cool",tag:4)
        
        let scrView = UIScrollView()
        scrView.frame = CGRectMake(65,192,240,400)
        
        //全体のサイズ
        scrView.contentSize = CGSizeMake(240*4, 300)
        
        self.view.addSubview(scrView)
        scrView.addSubview(ButtonCute)
        scrView.addSubview(ButtonSexy)
        scrView.addSubview(ButtonLovely)
        scrView.addSubview(ButtonCool)

        
        // １ページ単位でスクロールさせる
        scrView.pagingEnabled = true
        
        //scroll画面の初期位置
        scrView.contentOffset = CGPointMake(0, 0);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Jump to NavigationController
    func leftButtonTouch() {
        self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
    }
    
    func scrollImageButton(NoI:String,Fx:Int,Fy:Int,Fw:Int,Fh:Int,btnTitle:String,tag:Int) -> UIButton{
        
        //AppDelegateへの値渡し
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //AppDelegateのインスタンスを取得
        appDelegate.imageID = tag
        
        var btn:UIButton! = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        let SelectImage = UIImage(named:NoI)
        btn.frame = CGRect(x: Fx, y: Fy, width: Fw, height: Fh)
        //btn.setTitle(btnTitle, forState: UIControlState.Normal)
        btn.tag = tag
        btn.setBackgroundImage(SelectImage, forState: .Normal)
        btn.addTarget(nil, action:"switchTag:",forControlEvents: .TouchUpInside)
        return btn
    }
    
    func switchTag(sender:AnyObject){
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
        var imageID = appDelegate.imageID
        
        println("HOGE")
        println("あ\(sender.tag)")
        //println("い\(imageID)")
        
        
        let Selpic: SelectPic = SelectPic()
        let pushView: UINavigationController = UINavigationController(rootViewController: Selpic)
        self.navigationController?.pushViewController(pushView, animated: true)
        /*
        //AppDelegateへの値渡し
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        //AppDelegateのインスタンスを取得
        appDelegate.imageID = tag
        */
        
    }
    

    
    
}


