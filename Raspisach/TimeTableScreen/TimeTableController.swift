//
//  ViewController.swift
//  Raspisach
//
//  Created by Евгений Фомин on 09.05.2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit


class Item: Equatable {
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum types {
        case lesson
        case teacher
        case type
        case address
    }
    
    var id: UInt32!
    var value: String!
    var type: types!
    
    init(_ _value: String, type _type: types) {
        id = arc4random()
        value = _value
        type = _type
    }
}


class Lesson: Equatable {
    
    static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id: UInt32!
    var start: Date! = Date()
    var end: Date! = Date()
    var lesson: Item! = Item("Предмет", type: .lesson)
    var teacher: Item! = Item("Учитель", type: .teacher)
    var type: Item! = Item("Тип", type: .type)
    var address: Item! = Item("Кабинет", type: .address)
    var isFirstWeek = true
    
    init(start: Date, end: Date, lesson: Item, teacher: Item, type: Item, address: Item, isFirstWeek: Bool) {
        self.id = arc4random()
        self.start = start
        self.end = end
        self.lesson = lesson
        self.teacher = teacher
        self.type = type
        self.address = address
        self.isFirstWeek = isFirstWeek
        
    }
    
    init() {
        self.id = arc4random()
    }
}



class TimeTableController: UIViewController {
    
    @IBOutlet weak var addLesson: UIBarButtonItem!
    @IBOutlet weak var firstWeekButton: UIButton!
    @IBOutlet weak var secondWeekButton: UIButton!
    @IBOutlet weak var lessonsTableView: UITableView!
    
    enum modes {
        case first
        case second
    }
    
    var mode: modes! {
        didSet {
            firstWeekButton.setTitleColor(mode == .first ? .mainButtonColor : .gray, for: .normal)
            secondWeekButton.setTitleColor(mode == .second ? .mainButtonColor : .gray, for: .normal)
        }
    }
    
    var lessons: [Lesson] = [] {
        didSet {
            createSorted()
        }
    }
    
    func createSorted() {
        sortedLessons = lessons
            .sorted(by: {
                if ($0.start?.timeIntervalSinceReferenceDate ?? 0) < ($1.start?.timeIntervalSinceReferenceDate ?? 0) {
                    return true
                } else if $0.start?.timeIntervalSinceReferenceDate == $1.start?.timeIntervalSinceReferenceDate {
                    return $0.id < $1.id
                } else {
                    return false
                }
                
            })
            .filter({
                Calendar.current.dateComponents([.weekday], from: $0.start!).weekday == currentWeekday
            })
    }
    
    var sortedLessons: [Lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        lessonsTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mode = .first
        lessonsTableView.reloadData()
        
    }
    
    func setupViews() {
        firstWeekButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
    }
    
    @IBAction func tapSettingsButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func tapFirstButton(_ sender: UIButton) {
        mode = .first
        
    }
    
    @IBAction func tapSecondButton(_ sender: UIButton) {
        mode = .second
        
    }
    
    @IBAction func tapAddLesson(_ sender: UIBarButtonItem) {
        let newLesson = Lesson()
        let calendar = Calendar.current
        
        let currentDateComps = calendar.dateComponents([.year,
                                                        .month,
                                                        .weekdayOrdinal], from: Date())
        
        let templateComponents = DateComponents(calendar: calendar,
                                                year: currentDateComps.year,
                                                month: currentDateComps.month,
                                                weekday: currentWeekday,
                                                weekdayOrdinal: currentDateComps.weekdayOrdinal)
        
        let templateDate = calendar.date(from: templateComponents)
        
        newLesson.start = templateDate
        newLesson.end = templateDate?.addingTimeInterval(60*60)
        
        lessons.append(newLesson)
        lessonsTableView.reloadData()
    }
    
    var currentWeekday = 2 {
        didSet {
            createSorted()
            lessonsTableView.reloadData()
        }
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 6 {
            currentWeekday = 1
        } else {
            currentWeekday = sender.selectedSegmentIndex + 2
        }
        
        
    }
}


extension TimeTableController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedLessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonsCell") as! TimeTableCell
        cell.update(with: sortedLessons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setController = SetDataController.make(sortedLessons[indexPath.row])
        self.navigationController?.pushViewController(setController, animated: true)
    }
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title:  nil, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            if let index = self.lessons.index(of: self.sortedLessons[indexPath.row]) {
                self.lessons.remove(at: index)
                if self.lessons.count == 0 {
                    tableView.reloadSections([0], with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
            
            success(true)
        })
        deleteAction.image = #imageLiteral(resourceName: "delIcon")
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Удалить") { action, indexPath in
            if let index = self.lessons.index(of: self.sortedLessons[indexPath.row]) {
                self.lessons.remove(at: index)
                if self.lessons.count == 0 {
                    tableView.reloadSections([0], with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    
}


func async(queue: DispatchQueue = .main, after: Int = 0, _ block: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(after), execute: block)
}

