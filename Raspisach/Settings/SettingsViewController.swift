//
//  SettingsViewController.swift
//  Raspisach
//
//  Created by Евгений Фомин on 11.05.2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    public var selectedSetting: String?
    
    let settingsArray = ["Время занятий","Предметы","Преподаватели","Аудитории", "Тип занятий", "Уведомления", "Текущая неделя", "Поделиться расписанием"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsTableViewCell
        cell.settingLabel.text = settingsArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = settingsArray[indexPath.row]
        selectedSetting = row
        switch row {
            
            
        case "Текущая неделя":
            createChooseWeekAlert()
            
        default:
          
            performSegue(withIdentifier: "goDeeper", sender: self)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDeeper" {
            let destinationVC = segue.destination as! AddingClassInfo
            destinationVC.settingSelected = settingsArray
            destinationVC.navigationItem.title = selectedSetting
            
            
            
        }
    }
    
    func createChooseWeekAlert() {
        
        let alertController = UIAlertController(title: "Важно", message: "Какая сейчас неделя в расписани вашего университета?", preferredStyle: .alert)
        
        let firstWeekButton = UIAlertAction(title: "Первая неделя", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        let secondWeekButton = UIAlertAction(title: "Вторая неделя", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        let tryMeButton = UIAlertAction(title: "Догадайся сам", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        alertController.addAction(firstWeekButton)
        alertController.addAction(secondWeekButton)
        alertController.addAction(tryMeButton)
        alertController.addAction(cancelButton)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}
