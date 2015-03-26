//
//  ViewController.swift
//  FaceTracker
//
//  Created by 中原 啓雅 on 2015/03/19.
//  Copyright (c) 2015年 中原啓雅. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit
import QuartzCore

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var rstBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var processLabel: UILabel!
    // セッション
    var mySession : AVCaptureSession!
    // カメラデバイス
    var myDevice : AVCaptureDevice!
    // 出力先
    var myOutput : AVCaptureVideoDataOutput!
    var recognition = Recognition()
    var imcImageController: ImageController!

    override func viewDidLoad() {
        super.viewDidLoad()
        imcImageController = ImageController()
        // Do any additional setup after loading the view, typically from a nib.
        if initCamera() {
            mySession.startRunning()
        }
    }

    // カメラの準備処理
    func initCamera() -> Bool {
        // セッションの作成.
        mySession = AVCaptureSession()

        // 解像度の指定.
        mySession.sessionPreset = AVCaptureSessionPresetPhoto


        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()

        // フロントカメラをmyDeviceに格納.
        for device in devices {
            if(device.position == AVCaptureDevicePosition.Front){
                myDevice = device as AVCaptureDevice
            }
        }
        if myDevice == nil {
            return false
        }

        // フロントカメラからVideoInputを取得.
        let myInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput


        // セッションに追加.
        if mySession.canAddInput(myInput) {
            mySession.addInput(myInput)
        } else {
            return false
        }

        // 出力先を設定
        myOutput = AVCaptureVideoDataOutput()
        myOutput.videoSettings = [ kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA ]

        // FPSを設定
        var lockError: NSError?
        if myDevice.lockForConfiguration(&lockError) {
            if let error = lockError {
                println("lock error: \(error.localizedDescription)")
                return false
            } else {
                myDevice.activeVideoMinFrameDuration = CMTimeMake(1, 15)
                myDevice.unlockForConfiguration()
            }
        }

        var queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL);
        myOutput.setSampleBufferDelegate(self, queue: queue)

        // 遅れてきたフレームは無視する
        myOutput.alwaysDiscardsLateVideoFrames = true


        // セッションに追加.
        if mySession.canAddOutput(myOutput) {
            mySession.addOutput(myOutput)
        } else {
            return false
        }

        // カメラの向きを合わせる
        for connection in myOutput.connections {
            if let conn = connection as? AVCaptureConnection {
                if conn.supportsVideoOrientation {
                    conn.videoOrientation = AVCaptureVideoOrientation.Portrait
                }
            }
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 毎フレーム実行される処理
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!)
    {
        // UIImageへ変換して表示させる
        var image = imcImageController.createImageFromBuffer(sampleBuffer)
        var point1 = DrawPointInFace(0, x: 30.0, y: 0.0)
        var point2 = DrawPointInFace(1, x: 30.0, y: 0.0)
        var array = NSArray(array: [point1, point2])
        image = recognition.Apply(image, drawPoints: array)

        dispatch_async(dispatch_get_main_queue(), {
            self.view.layer.contents = image.CGImage
        })
    }

    @IBAction func onClick(sender: UIButton) {
        self.recognition.FrameReset()
    }

    @IBAction func onClickNextBtn(sender: UIButton) {
        //self.recognition.PrintPoints()
        var points = recognition.GetPoints() as [AnyObject] as [NSNumber]
        for point in points {
            NSLog("%@", point)
        }
    }
}
