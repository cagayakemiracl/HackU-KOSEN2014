//
//  ViewController.swift
//  CameraTest
//
//  Created by 中原 啓雅 on 2014/12/30.
//  Copyright (c) 2014年 中原啓雅. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Start Camera
        let videoDisplayOfTheCamera = VideoDisplayOfTheCamera.Front(
            layer: self.view.layer,
            frame: self.view.bounds)
        videoDisplayOfTheCamera.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
