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
    var imcImageController = ImageController()

    var processString = [String]()
    var pointArray = [NSArray]()
    var processIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initProcessString()
        initPointArray()
        self.processLabel.text = self.processString[0]
        if initCamera() {
            mySession.startRunning()
        }
    }

    func initProcessString() {
        // やはりWEBアプリにしてデータベースに保存したい
        self.processString.append("化粧水などで肌を整える")
        self.processString.append("BBクリームを5カ所に分けてまんべんなく塗る")
        self.processString.append("ファンデーションでテカリを抑える")
        self.processString.append("眉毛はナチュラルに仕上げるために髪より少し明るいカラーを選ぶ")
        self.processString.append("アイラインのポイントは目頭の切開ラインと目尻のラインを長めにまたはねさせる")
        self.processString.append("アイシャドウは濃いブラウンでラインをぼかす")
        self.processString.append("明るいブラウンまたはカラー")
        self.processString.append("ホワイト")
        self.processString.append("3分の1程ブラウンのラインを引く")
        self.processString.append("ホワイトを乗せて涙袋を強調する")
        self.processString.append("まつ毛は全体を上げた後に目頭から目の中心のまつ毛だけを3段階に分け上げる")
        self.processString.append("マスカラは目頭から目の中心のまつ毛を上に目尻側のまつ毛は流すように意識して付ける")
        self.processString.append("下まつげにも程よくマスカラを乗せて")
    }

    func initPointArray() {
        // やはりWEBアプリにしてデータベースに保存したい
        var array:NSArray!
        var p1: DrawPointInFace!
        var p2: DrawPointInFace!
        var p3: DrawPointInFace!
        var p4: DrawPointInFace!
        var p5: DrawPointInFace!

        array = NSArray(array: [])
        self.pointArray.append(array)

        p1 = DrawPointInFace(21, x: 10, y: -20)
        p2 = DrawPointInFace(2, x: 20, y: 0)
        p3 = DrawPointInFace(29, x: 0, y: 0)
        p4 = DrawPointInFace(14, x: -20, y: 0)
        p5 = DrawPointInFace(8, x: 0, y: -10)
        array = NSArray(array: [p1, p2, p3, p4, p5])
        self.pointArray.append(array)

        array = NSArray(array: [])
        self.pointArray.append(array)

        p1 = DrawPointInFace(19, x: 0, y: 0)
        p2 = DrawPointInFace(24, x: 0, y: 0)
        array = NSArray(array: [p1, p2])
        self.pointArray.append(array)

        p1 = DrawPointInFace(37, x: 0, y: 0)
        p2 = DrawPointInFace(43, x: 0, y: 0)
        array = NSArray(array: [p1, p2])
        self.pointArray.append(array)

        p1 = DrawPointInFace(36, x: 0, y: 0)
        p2 = DrawPointInFace(45, x: 0, y: 0)
        array = NSArray(array: [p1, p2])
        self.pointArray.append(array)

        p1 = DrawPointInFace(36, x: -10, y: -10)
        array = NSArray(array: [p1])
        self.pointArray.append(array)

        p1 = DrawPointInFace(17, x: 0, y: 10)
        array = NSArray(array: [p1])
        self.pointArray.append(array)

        p1 = DrawPointInFace(41, x: 10, y: 5)
        array = NSArray(array: [p1])
        self.pointArray.append(array)

        p1 = DrawPointInFace(47, x: 5, y: 5)
        array = NSArray(array: [p1])
        self.pointArray.append(array)

        array = NSArray(array: [])
        self.pointArray.append(array)

        p1 = DrawPointInFace(37, x: 0, y: -5)
        array = NSArray(array: [])
        self.pointArray.append(array)

        array = NSArray(array: [])
        self.pointArray.append(array)

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
        image = recognition.Apply(image, drawPoints: self.pointArray[self.processIndex])

        dispatch_async(dispatch_get_main_queue(), {
            self.view.layer.contents = image.CGImage
        })
    }

    func changeProcessLabel() {
        self.processLabel.text = self.processString[self.processIndex]
        self.processLabel.sizeToFit()
    }

    @IBAction func onClick(sender: UIButton) {
        self.recognition.FrameReset()
    }

    @IBAction func onClickNextBtn(sender: UIButton) {
        if self.processIndex == 0 { return }
        self.processIndex += 1
        changeProcessLabel()
    }

    @IBAction func onClickBackBtn(sender: UIButton) {
        if self.processIndex == processString.count { return }
        self.processIndex -= 1
        changeProcessLabel()
    }
}
