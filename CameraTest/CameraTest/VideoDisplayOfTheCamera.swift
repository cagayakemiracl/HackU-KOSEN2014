//
//  VideoDisplayOfTheCamera.swift
//  CameraTest
//
//  Created by 中原 啓雅 on 2014/12/30.
//  Copyright (c) 2014年 中原啓雅. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoDisplayOfTheCamera {

    var _session: AVCaptureSession?

    init(layer: CALayer, frame: CGRect, position: AVCaptureDevicePosition) {
        // init camera device
        var captureDevice: AVCaptureDevice?
        let devices = AVCaptureDevice.devices()

        for device in devices {
            if device.position == position {
                captureDevice = device as? AVCaptureDevice
            }
        }

        if captureDevice != nil {
            println(captureDevice!.localizedName)
            println(captureDevice!.modelID)
        } else {
            println("Missing Camera")
            return
        }

        // init device input
        var error: NSErrorPointer!
        let deviceInput = AVCaptureDeviceInput.deviceInputWithDevice(
            captureDevice,
            error: error) as AVCaptureInput

        let stillImageOutput = AVCaptureStillImageOutput()
        self._session = AVCaptureSession()

        // init session
        self._session!.sessionPreset = AVCaptureSessionPresetPhoto
        self._session?.addInput(deviceInput)
        self._session?.addOutput(stillImageOutput)

        // layer for preview
        var previewLayer =
            AVCaptureVideoPreviewLayer.layerWithSession(self._session)
            as AVCaptureVideoPreviewLayer
        previewLayer.frame = frame
        layer.addSublayer(previewLayer)
    }

    func start() {
        self._session?.startRunning()
    }

    func stop() {
        self._session?.stopRunning()
    }

    class Back: VideoDisplayOfTheCamera  {
        init(layer: CALayer, frame: CGRect) {
            super.init(
                layer: layer,
                frame: frame,
                position: AVCaptureDevicePosition.Back)
        }
    }

    class Front: VideoDisplayOfTheCamera {
        init(layer: CALayer, frame: CGRect) {
            super.init(
                layer: layer,
                frame: frame,
                position: AVCaptureDevicePosition.Front)
        }
    }
}
