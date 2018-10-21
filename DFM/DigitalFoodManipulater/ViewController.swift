//
//  ViewController.swift
//  DigitalFoodManipulater
//
//  Created by 佐野文哉 on 2018/10/19.
//  Copyright © 2018年 Jenove_ze. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var receipt: UIImageView!
    //カメラローfルを表示する
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func camera_select(_ sender: Any) {
        //カメラロールを表示する
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //カメラロールで処理が終わった時に呼び出される
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //カメラロールを閉じて
        imagePicker.dismiss(animated: true, completion: nil)
        //選択した画像があれば
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        // イメージビューの表示
        receipt.image = image
    }
}
