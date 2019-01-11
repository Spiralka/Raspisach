//
//  Lesson+CoreDataProperties.swift
//  Raspisach
//
//  Created by  Евгений on 02/11/2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var teacher: String?
    @NSManaged public var place: String?
    @NSManaged public var startTime: NSDate?
    @NSManaged public var endTime: NSDate?

}
