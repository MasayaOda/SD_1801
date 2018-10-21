//
//  FoodController.swift
//  DigitalFoodManipulater
//
//  Created by 佐野文哉 on 2018/10/19.
//  Copyright © 2018年 Jenove_ze. All rights reserved.
//
import UIKit
import Foundation

class FoodController: UITableViewController {
    
    var all_items: Array<Item> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let data = UserDefaults.standard.data(forKey: "array")
        if data != nil {
            all_items = NSKeyedUnarchiver.unarchiveObject(with: data!) as! Array<Item>
        }
        all_items.sort()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "selectCell", for: indexPath) as? SelectTableViewCell else {
            return UITableViewCell()
        }
        
        let itemData = all_items[indexPath.row]
        
        cell.itemNameLabel.text = itemData.getName()
        cell.itemDateLabel.text = itemData.getStringfromDate()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            all_items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let archiveData = NSKeyedArchiver.archivedData(withRootObject: all_items)
            UserDefaults.standard.set(archiveData, forKey: "array")
            UserDefaults.standard.synchronize()
        }
    }
    
}
