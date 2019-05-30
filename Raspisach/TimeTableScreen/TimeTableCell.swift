//
//  LessonsTableViewCell.swift
//  Raspisach
//
//  Created by Евгений Фомин on 09.05.2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import UIKit

class TimeTableCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lesson_title: UILabel!
    @IBOutlet weak var teacher_name: UILabel!
    @IBOutlet weak var classRoom_title: UILabel!
    
    
    func update(with lesson: Lesson) {
        startTimeLabel.text = lesson.start?.description
        endTimeLabel.text = lesson.end?.description
        typeLabel.text = lesson.type?.value
        lesson_title.text = lesson.lesson?.value
        teacher_name.text = lesson.teacher?.value
        classRoom_title.text = lesson.address?.value
        
    }
}
