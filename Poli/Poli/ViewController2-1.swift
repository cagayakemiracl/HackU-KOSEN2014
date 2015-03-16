//
//  ViewController.swift
//  Poli
//
//  Created by 西村 礼恩 on 2015/02/24.
//  Copyright (c) 2015年 西村 礼恩. All rights reserved.
//

import UIKit



class ViewController21: UIViewController {
    /*

    @IBOutlet weak var iv2: UIImageView!
    
    @IBOutlet weak var iv: UIImageView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    var img = UIImage(named:"paint 2.png")
        iv.image = img
        iv2.image = img
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    var touch = touches.anyObject() as UITouch
    println(touch.view.tag)
    switch(touch.view.tag){
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIImageに画像の名前を指定します//cute, sexy, lovely, cool
        let img_cute = UIImage(named:"cute.jpeg");
        let img_sexy = UIImage(named:"sexy.jpeg");
        let img_lovely = UIImage(named:"lovely.jpeg");
        let img_cool = UIImage(named:"cool.jpeg");
        /*
        let img1 = UIImage(named:"img1.jpg");
        let img2 = UIImage(named:"img2.jpg");
        let img3 = UIImage(named:"img3.jpg");
        */
        
        //UIImageViewにUIIimageを追加
        let ViewCute = UIImageView(image:img_cute)
        let ViewSexy = UIImageView(image:img_sexy)
        let ViewLovely = UIImageView(image:img_lovely)
        let ViewCool = UIImageView(image:img_cool)
        ViewLovely.userInteractionEnabled = true;
        ViewSexy.userInteractionEnabled = true;
        ViewCute.userInteractionEnabled = true;
        ViewCool.userInteractionEnabled = true;
        
        
        //let touch = touches.anyObject() as UITouch
        
        
        /*
        http://zutto-megane.com/objective-c/post-300/
        UIImageView *tapView = [[UIImageView alloc]init];
        //タップを有効化する。
        tapView.userInteractionEnabled = YES;
        
        UIImageView *tapView = [[UIImageView alloc]init];
        //タップを有効化する。
        tapView.userInteractionEnabled = YES;
        //タグを設定する。
        tapView.tag = 1;
        
        - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
        {
        
        UITouch *touch = [touches anyObject];
        NSLog( @"%d",touch.view.tag );
        switch (touch.view.tag) {
            case 1:
                // 1のタグがタップされた場合の処理を記述
                break;
            case 2:
                // 2のタグがタップされた場合の処理を記述
                break;
            case 3:
                // 3のタグがタップされた場合の処理を記述
                break;
            default:
                break;
        }
        
        }
        */
        
        //UIScrollViewを作成します
        let scrView = UIScrollView()
        
        //表示位置 + 1ページ分のサイズ
        //720 × 1280
        /*
        scrView.frame = CGRectMake(50, 50, 240, 240)
        
        //全体のサイズ
        scrView.contentSize = CGSizeMake(240*4, 240)
        
        
        

        */
        scrView.frame = CGRectMake(65, 100, 240, 1680/720*240)
        
        //全体のサイズ
        scrView.contentSize = CGSizeMake(240*4, 1680/720*240)
        
        
        
        //UIImageViewのサイズと位置を決めます
        //左右に並べる
        ViewCute.frame = CGRectMake(0, 0, 240, 1680/720*240)
        ViewSexy.frame = CGRectMake(240, 0, 240, 1280/720*240)
        ViewLovely.frame = CGRectMake(240*2, 0, 240, 1280/720*240)
        ViewCool.frame = CGRectMake(240*3, 0, 240, 1280/720*240)
        
        //viewに追加します
        self.view.addSubview(scrView)
        scrView.addSubview(ViewCute)
        scrView.addSubview(ViewSexy)
        scrView.addSubview(ViewLovely)
        scrView.addSubview(ViewCool)
        /*
        //viewに追加します
        self.view.addSubview(scrView)
        scrView.addSubview(imageView1)
        scrView.addSubview(imageView2)
        scrView.addSubview(imageView3)
        */
        
        // １ページ単位でスクロールさせる
        scrView.pagingEnabled = true
        
        //scroll画面の初期位置
        scrView.contentOffset = CGPointMake(0, 0);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



