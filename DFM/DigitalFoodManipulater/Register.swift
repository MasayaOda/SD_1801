//
//  Register.swift
//  DigitalFoodManipulater
//
//  Created by 佐野文哉 on 2018/10/20.
//  Copyright © 2018年 Jenove_ze. All rights reserved.
//

import UIKit
import UserNotifications

class Register: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    var name:String = "食品名を入力してください"
    var datePicker: UIDatePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        

        
        
        // Do any additional setup after loading the view.
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        
        
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
        
        var defaultDate = Date(timeInterval: +60*60*24*7, since: Date())
        
        let formatter = DateFormatter()
        nameField.insertText(name)
        formatter.dateFormat = "yyyy年MM月dd日まで"
        dateField.insertText(formatter.string(from: defaultDate))
        datePicker.date = defaultDate
        
    }
    
    @objc func done() {
        dateField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日まで"
        dateField.text = "\(formatter.string(from: datePicker.date))"
        _ = formatter.date(from: dateField.text!)
    }
    
    @IBAction func onTap(_ sender: UIButton) {
        

        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日まで"
        let item = Item(name: nameField.text!,
                        date: formatter.date(from: dateField.text!)!)
        
        let alertController = UIAlertController(
            title: "登録！",
            message: item.name + "を登録しますか？",
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "キャンセル",
                style: .cancel,
                handler: nil
            )
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
        
            var all_items: Array<Item> = []
        
            //取得
            let data = UserDefaults.standard.data(forKey: "array")
            if data != nil {
                all_items = NSKeyedUnarchiver.unarchiveObject(with: data!) as! Array<Item>
            }
        
                //UserDefaultsへ
        
            all_items.append(item)
            let archiveData = NSKeyedArchiver.archivedData(withRootObject: all_items)
            UserDefaults.standard.set(archiveData, forKey: "array")
            UserDefaults.standard.synchronize()
        
        
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
            // エラー処理
            }
        
            let content = UNMutableNotificationContent()
        
            content.title = NSString.localizedUserNotificationString(forKey: item.getName() + "の期限が明日までです！", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "美味しいうちに食べましょう！", arguments: nil)
            content.sound = UNNotificationSound.default
        
        
            let beforeDay = Date(timeInterval: -60*60*24, since: item.getDate())
        
            var fireDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: beforeDay)
            fireDate.hour = 13
            fireDate.minute = 00
            print(fireDate)
        
            let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
            let request = UNNotificationRequest(identifier: "my-notification", content: content, trigger: trigger)
        
            // 通知を登録
            center.add(request) { (error : Error?) in
                if error != nil {
                    // エラー処理
                }
            }
        }
            )
        )
        present(alertController, animated: true, completion: nil)
    }


}
