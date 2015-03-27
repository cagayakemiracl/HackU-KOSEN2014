//
//  DrawerMenu2_1_1.swift
//  Poli
//
//  Created by Ashigirl96 on 2015/03/14.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

//import Foundation

//
//import UIkit
//
//class MenuView :AirbnbViewController,AirbnbMenuDelegate,AirbnbMenuDataSource{
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.whiteColor()
//    }
//    
//    // AirbnbMenuDelegate
//    
//    func didSelectRowAtIndex(indexPath: NSIndexPath) {
//        println("you select \(indexPath.row) in \(indexPath.section)")
//    }
//    
//    func willShowAirViewController() {
//        println("willShowAirViewController")
//    }
//    
//    func willHideAirViewController() {
//        println("willHideAirViewController")
//    }
//    
//    func didHideAirViewController() {
//        println("didHideAirViewController")
//    }
//    
//    func heightForAirMenuRow() -> CGFloat {
//        return 60.0
//    }
//    
//    // AirbnbDatasource
//    
//    override func numberOfSession() -> Int {
//        return 2
//    }
//    
//    override func numberOfRowsInSession(session: Int) -> Int {
//        //sessionに何個の行が必要か
//        switch session {
//        case 0:
//            return 1
//        default:
//            return 5
//        }
//    }
//    
//    override func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
//        switch indexPath.section{
//        case 0:
//            return "ホーム画面"
//        default:
//            switch indexPath.row{
//            case 0:
//                return ""
//            case 1:
//                return "1"
//            case 2:
//                return "2"
//            case 3:
//                return ""
//            case 4:
//                return "4"
//            case 5:
//                return "5"
//            default:
//                return "hoge"
//            }
//        }
//    }
//    
//    override func titleForHeaderAtSession(session: Int) -> String {
//        switch session {
//        case 0:
//            return "メニュー"
//        default:
//            return "お気に入りリスト"
//        }
//    }
//    
//    func thumbnailImageAtIndexPath(indexPath: NSIndexPath) -> UIImage? {
//        return nil
//    }
//    
//    func viewControllerForIndexPath(indexPath: NSIndexPath) -> UIViewController {
//        
//        switch indexPath.row {
//        case 0://コードで画面遷移
//            //別のswiftファイルを行き先に指定
//            let nView: GuideView = GuideView()
//            let controller: UINavigationController = UINavigationController(rootViewController: nView)
//            return controller
//            
//        case 1://StoryboardのIDで画面遷移
//            //まずはStoryboardを探すところから！
//            var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//            
//            //Storyboard内から指定したID("nextStory")を持った部品を探す！
//            //instantiateViewControllerWithIdentifierの引数は、遷移してほしい画面のID
//            let nextSBView : AnyObject! = storyboard.instantiateViewControllerWithIdentifier("nextStory") as UIViewController
//            
//            //そのViewを行き先に指定
//            let controller: UINavigationController = UINavigationController(rootViewController: nextSBView as UIViewController)
//            return controller
//            
//        default:
//            let nView: GuideView = GuideView()
//            let controller: UINavigationController = UINavigationController(rootViewController: nView)
//            return controller
//        }
//
//    }
//}




import UIkit

class MenuView :AirbnbViewController,AirbnbMenuDelegate,AirbnbMenuDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.whiteColor()
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
        //sessionに何個の行が必要か
        switch session {
        case 0:
            return 8
        default:
            return 0
        }
    }
    
    override func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                return "ホーム画面"
            case 1:
                return ""
            case 2:
                return "シンプルにクール"
            case 3:
                return "ふんわりピュア"
            case 4:
                return "春色ルージュに夢中"
            case 5:
                return "透明感のあるペールトーン"
            case 6:
                return "清楚感のあるベージュリップ"
            case 7:
                return "ベリー色で大人の色気"
            default:
                return ""
            }
        default:
            return ""
        }
    }
    
    override func titleForHeaderAtSession(session: Int) -> String {
        switch session {
        case 0:
            return "メニュー"
        default:
            return ""
        }
    }
    
    func thumbnailImageAtIndexPath(indexPath: NSIndexPath) -> UIImage? {
        return nil
    }
    
    func viewControllerForIndexPath(indexPath: NSIndexPath) -> UIViewController {
        
        switch indexPath.row {
        case 0://コードで画面遷移
            //別のswiftファイルを行き先に指定
            let HomeView: SelectMenuController = SelectMenuController()
            let controller: UINavigationController = UINavigationController(rootViewController: HomeView)
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
