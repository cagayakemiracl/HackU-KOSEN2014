//
//  DrawerMenu2_1_1.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/14.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

//import Foundation
import UIkit

class MenuView :AirbnbViewController,AirbnbMenuDelegate,AirbnbMenuDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    // AirbnbMenuDelegate
    
    func didSelectRowAtIndex(indexPath: NSIndexPath) {
        println("you select \(indexPath.row) in \(indexPath.section)")
    }
    
    func willShowAirViewController() {
        println("willShowAirViewController")
    }
    
    func willHideAirViewController() {
        println("willHideAirViewController")
    }
    
    func didHideAirViewController() {
        println("didHideAirViewController")
    }
    
    func heightForAirMenuRow() -> CGFloat {
        return 60.0
    }
    
    // AirbnbDatasource
    
    override func numberOfSession() -> Int {
        return 1
    }
    
    override func numberOfRowsInSession(session: Int) -> Int {
        return 5
    }
    
    override func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
        switch indexPath.row{
        case 0:
            return "0"
        case 1:
            return "1"
        case 2:
            return "2"
        case 3:
            return "3"
        case 4:
            return "4"
        case 5:
            return "5"
        default:
            return "hoge"
        }
    }
    
    override func titleForHeaderAtSession(session: Int) -> String {
        return "お気に入りリスト"
    }
    
    func thumbnailImageAtIndexPath(indexPath: NSIndexPath) -> UIImage? {
        return nil
    }
    
    func viewControllerForIndexPath(indexPath: NSIndexPath) -> UIViewController {
        
        switch indexPath.row {
        case 0://コードで画面遷移
            //別のswiftファイルを行き先に指定
            let nView: GuideView = GuideView()
            let controller: UINavigationController = UINavigationController(rootViewController: nView)
            return controller
            
        case 1://StoryboardのIDで画面遷移
            //まずはStoryboardを探すところから！
            var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            //Storyboard内から指定したID("nextStory")を持った部品を探す！
            //instantiateViewControllerWithIdentifierの引数は、遷移してほしい画面のID
            let nextSBView : AnyObject! = storyboard.instantiateViewControllerWithIdentifier("nextStory") as UIViewController
            
            //そのViewを行き先に指定
            let controller: UINavigationController = UINavigationController(rootViewController: nextSBView as UIViewController)
            return controller
            
        default:
            let nView: GuideView = GuideView()
            let controller: UINavigationController = UINavigationController(rootViewController: nView)
            return controller
        }

    }
}