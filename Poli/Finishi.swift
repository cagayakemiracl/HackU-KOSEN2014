
//
//  Finishi.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/27.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

import Social
//import Foundation
import UIKit
import SystemConfiguration

class FinishView: UIViewController {
    
    let y:CGFloat = 504
    let offset:CGFloat = 13
    let size:CGFloat = 90
    var label: UILabel!
    var mailButton: UIButton!
    var finishView: UIImageView!
    var myComposeView : SLComposeViewController!
    var TwitterButton: UIButton!
    var FacebookButton: UIButton!
    var twitter_image = UIImage(named: "twitter_button.jpeg") as UIImage?
    var facebook_image = UIImage(named: "facebook_button.jpeg") as UIImage?
    var mail_image = UIImage(named: "mail_button.jpeg") as UIImage?
    
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
        
        // Twitterボタン
        TwitterButton = UIButton()
        //TwitterButton.frame = CGRectMake(0,0,100,100)
        TwitterButton.frame = CGRectMake(38,y+offset,size,size)
        TwitterButton.setBackgroundImage(twitter_image, forState: UIControlState.Normal)
        TwitterButton.layer.masksToBounds = true
        TwitterButton.setTitle("Twitter", forState: UIControlState.Normal)
        TwitterButton.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        TwitterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        TwitterButton.layer.cornerRadius = 50.0
        //TwitterButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2)
        TwitterButton.tag = 1
        TwitterButton.addTarget(self, action: "TwitterPost:", forControlEvents: .TouchUpInside)
        
        // Facebook ボタン
        FacebookButton = UIButton()
        FacebookButton.frame = CGRectMake(147,y-offset,size,size)
        FacebookButton.setBackgroundImage(twitter_image, forState: UIControlState.Normal)
        FacebookButton.layer.masksToBounds = true
        FacebookButton.setTitle("Facebook", forState: UIControlState.Normal)
        FacebookButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        FacebookButton.addTarget(self, action: "FacebookPost:", forControlEvents: UIControlEvents.TouchUpInside)
        FacebookButton.layer.cornerRadius = 50.0
        //FacebookButton.layer.position = CGPointMake(self.view.frame.width/2, 200)
        
        //UIボタンを生成.
        mailButton = UIButton(frame: CGRectMake(247,y+offset,size,size))
        mailButton.setBackgroundImage(mail_image, forState: UIControlState.Normal)
        mailButton.layer.masksToBounds = true
        mailButton.setTitle("Mail", forState: .Normal)
        mailButton.layer.cornerRadius = 50.0
        //mailButton.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        mailButton.addTarget(self, action: "mailPost:", forControlEvents: .TouchUpInside)
        
        
        
        
        label = UILabel(frame: CGRectMake(65,75,240,60))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.text = "Finish!!"
        label.font = UIFont.boldSystemFontOfSize(66)
        
        finishView = UIImageView(frame: CGRectMake(67, 180, 240, 240))
        let fimg = UIImage(named: "finish.jpeg")
        finishView.image = fimg
        

        // buttonとLabelをviewに追加
        
        self.view.addSubview(label)
        self.view.addSubview(finishView)
        self.view.addSubview(FacebookButton)
        self.view.addSubview(TwitterButton)
        self.view.addSubview(mailButton)
    }
    
    func FacebookPost(sender : AnyObject) {
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        myComposeView.setInitialText("TEST:戸塚くんは天使")
        myComposeView.addImage(UIImage(named: "finish.jpeg"))
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    func TwitterPost(sender : AnyObject) {
        // SLComposeViewControllerのインスタンス化.
        // ServiceTypeをTwitterに指定.
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        // 投稿するテキストを指定.
        myComposeView.setInitialText("TEST:戸塚くんは天使")
        // 投稿する画像を指定.
        myComposeView.addImage(UIImage(named: "finish.jpeg"))
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
    func mailPost(sender: UIButton){
        
        let myMailURL : NSURL = NSURL(string: "mailto:")!
        UIApplication.sharedApplication().openURL(myMailURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func leftButtonTouch() {
        self.airViewController?.showAirViewFromViewController(self.navigationController, complete: nil)
    }
    ////////
}