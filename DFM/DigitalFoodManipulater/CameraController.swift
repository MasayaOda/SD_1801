//
//  CameraController.swift
//  DigitalFoodManipulater
//
//  Created by 佐野文哉 on 2018/10/19.
//  Copyright © 2018年 Jenove_ze. All rights reserved.
//

import UIKit
import AVFoundation

class CameraController: UIViewController {
    let output = AVCapturePhotoOutput()
    @IBOutlet weak var previewView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カメラデバイスの入力を取得
        guard let device = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: device) else {
                return
                }
        //カメラをキャプチャするためのセッションとプレビュー用のレイヤーを取得
        let session = AVCaptureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        //イメージビューと同じ表示になるようにプレビューを設定
        previewLayer.frame = previewView.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
        
        //セッション開始
        session.addInput(input)
        session.addOutput(output)
        session.startRunning()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTap(_ sender: Any) {
        let settions = AVCapturePhotoSettings()//デフォルト設定をしよう
    }
       
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
