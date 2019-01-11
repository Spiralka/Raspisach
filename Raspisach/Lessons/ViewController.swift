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
    
//    fileprivate var fetchResults: NSFetchedResultsController<Lesson>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)

//        fetchResults = Lesson.mainFetchController
//        fetchResults.delegate = self
//        try? fetchResults.performFetch()
        
    }
    
    @IBAction func tapSettingsButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "2") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    @IBAction func tapFirstButton(_ sender: UIButton) {
        secondButton.setTitleColor(UIColor(hex: "D23E47"), for: UIControl.State.normal)
        firstButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
    @IBAction func tapSecondButton(_ sender: UIButton) {
        firstButton.setTitleColor(UIColor(hex: "D23E47"), for: UIControl.State.normal)
        secondButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
//    @IBAction func addButton(_ sender: UIBarButtonItem) {
//        let newLesson = Lesson(entity: Lesson.entitys, insertInto: CoreDataService.shared.context)
//        newLesson.title = "Тестовый урок кордата"
//        newLesson.startDate = Date()
//
//        let newTeacher = Teacher(entity: Teacher.entitys, insertInto: CoreDataService.shared.context)
//        newTeacher.fullName = "Иван Иванович"
//        newLesson.teacher = newTeacher
//
//        let newClassRoom = Classroom(entity: Classroom.entitys, insertInto: CoreDataService.shared.context)
//        newClassRoom.title = "Дома"
//        newLesson.classroom = newClassRoom
//        CoreDataService.shared.save()
//
//
//
//
//    }
    
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.lessonsTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.lessonsTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            self.lessonsTableView.deleteRows(at: [indexPath].compactMap({$0}), with: .automatic)
        case .insert:
            self.lessonsTableView.insertRows(at: [indexPath, newIndexPath].compactMap({$0}), with: .left)
        case .move:
            if indexPath != nil && newIndexPath != nil {
                self.lessonsTableView.moveRow(at: indexPath!, to: newIndexPath!)
            }
        case .update:
            self.lessonsTableView.reloadRows(at: [indexPath].compactMap({$0}), with: .none)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return fetchResults?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fetchResults.sections?[section].numberOfObjects ?? 0
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let currentObject = fetchResults.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsCell") as! LessonsTableViewCell
//        cell.lesson_title.text = currentObject.title
//        cell.teacher_name.text = currentObject.teacher?.fullName ?? ""
//        cell.classRoom_title.text = currentObject.classroom?.title ?? ""
        return cell
    }


    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
//            CoreDataService.shared.context.delete(self.fetchResults.object(at: indexPath))
//            CoreDataService.shared.save()

            success(true)
        })
        deleteAction.image = #imageLiteral(resourceName: "delIcon")
        deleteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }


     func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Удалить") { action, index in
//            CoreDataService.shared.context.delete(self.fetchResults.object(at: editActionsForRowAt))
//            CoreDataService.shared.save()
        }

        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    
}


func async(queue: DispatchQueue = .main, after: Int = 0, _ block: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(after), execute: block)
}

