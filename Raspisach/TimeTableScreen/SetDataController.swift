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
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    

}

extension SetDataController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SetDataCell
        return cell
        
    }
    
    
}
