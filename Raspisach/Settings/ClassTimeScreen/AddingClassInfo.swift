//
//  ClassTimeViewController.swift
//  Raspisach
//
//  Created by  Евгений on 18/10/2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit
import CoreData

class AddingClassInfo: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
     var typeOfSetting: String? = ""
    
    var dataManager = CoreDataManager()
    
    var settingSelected: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        typeCoreData()
        dataManager.read { (lol, kek, cheburek, l, d) in
            print("\(lol, kek, cheburek, l, d)")
        }
        
    }
    
    func typeCoreData() {
        switch navigationItem.title {
        case "Время занятий":
            typeOfSetting = "time"
            print("Время занятий")
        case "Предметы":
            typeOfSetting = "title"
            print("Предметы")
        case "Преподаватели":
            typeOfSetting = "teacher"
            dataManager.save(value: "Борисыч", type: typeOfSetting) { (isSuc) in
                if isSuc {
                    print("eee, boy")
                }
            }
            print("Преподаватели")
        case "Тип занятий":
            typeOfSetting = "type"
            print("Время занятий")
        case "Аудитории":
            typeOfSetting = "place"
            print("Аудитории")
        default:
            break
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
   

}

extension AddingClassInfo: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingSelected.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddingClassInfoCell
        cell.textField.text = settingSelected[indexPath.row]
        return cell
    }
    
    
}

extension AddingClassInfo: UITableViewDelegate {
    
}
