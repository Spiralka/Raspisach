//
//  ViewController.swift
//  Raspisach
//
//  Created by Евгений Фомин on 09.05.2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var lessonsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)

        
    }
    
    @IBAction func tapSettingsButton(_ sender: UIBarButtonItem) {
      
    }
    @IBAction func tapFirstButton(_ sender: UIButton) {
        secondButton.setTitleColor(UIColor(hex: "D23E47"), for: UIControl.State.normal)
        firstButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
    @IBAction func tapSecondButton(_ sender: UIButton) {
        firstButton.setTitleColor(UIColor(hex: "D23E47"), for: UIControl.State.normal)
        secondButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
    
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.lessonsTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.lessonsTableView.beginUpdates()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsCell") as! LessonsTableViewCell

        return cell
    }


    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            


            success(true)
        })
        deleteAction.image = #imageLiteral(resourceName: "delIcon")
        deleteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }


     func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Удалить") { action, index in
        }

        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    
}


func async(queue: DispatchQueue = .main, after: Int = 0, _ block: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(after), execute: block)
}

