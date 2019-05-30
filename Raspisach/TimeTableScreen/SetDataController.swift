//
//  SetDataController.swift
//  Raspisach
//
//  Created by  Евгений on 11/01/2019.
//  Copyright © 2019 Евгений Фомин. All rights reserved.
//

import UIKit

class SetDataController: UIViewController {
    
    class func make(_ lesson: Lesson) -> SetDataController {
        let new = UIStoryboard(name: "TimeTableScreen", bundle: nil).instantiateViewController(withIdentifier: "SetDataController") as! SetDataController
        new.lesson = lesson
        return new
    }
    
    var lesson: Lesson!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
