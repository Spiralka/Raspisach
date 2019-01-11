//
//  CoreDataManager.swift
//  Raspisach
//
//  Created by  Евгений on 02/11/2018.
//  Copyright © 2018 Евгений Фомин. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var entity: Lesson?
    let coreDataStack = CoreDataStack()
    
    func save(value: Any?, type: String?, handler: @escaping (Bool) -> Void) {
        let context = coreDataStack.saveContext
        let lesson = NSEntityDescription.insertNewObject(forEntityName: "Lesson", into: coreDataStack.saveContext) as? Lesson
        
        switch type {
        case "teacher":
            lesson?.teacher = value as? String
        case "title":
            lesson?.title = value as? String
        case "type":
            lesson?.type = value as? String
        case "startTime":
            lesson?.startTime = value as? NSDate
        case "endTime":
            lesson?.endTime = value as? NSDate
        default:
            print(#function, "Can't switch type")
        }
        coreDataStack.trySave(context: context)
    }
    
    func read(handler: @escaping (_ teacher:String,_ title: String,_ type: String,_ startTime: Date,_ endTime: Date) -> Void) {
        let context = coreDataStack.saveContext
        let request = NSFetchRequest<Lesson>(entityName: "Lesson")
        let result = try? context.fetch(request)
//        for lesson in result! {
//            guard let teacher = lesson.teacher else { return }
//            guard let title = lesson.title else { return }
//            guard let type = lesson.type else { return }
//            guard let startTime = lesson.startTime else { return }
//            guard let endTime = lesson.endTime else { return }
//        }
//        print("КОЛ-ВО ЗАПИСЕЙ ПРЕПОДОВ\(result?.count)")
        let teachers = result?.compactMap({ (lesson) -> String? in
            return lesson.teacher
        })
//            let lesson = result
//        let lesson = result?.last
        
//        print(lesson?.teacher)
        
        async {
            guard let teacher = teachers else { return }
            guard let title = lesson?.title else { return }
            guard let type = lesson?.type else { return }
            guard let startTime = lesson?.startTime else { return }
            guard let endTime = lesson?.endTime else { return }
            handler(teacher, title, type, startTime as Date, endTime as Date)
        }
    }
}

class CoreDataStack {
    
    let modelUrl = Bundle.main.url(forResource: "LessonDataModel", withExtension: "momd")!
    
    var storeUrl : URL {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsUrl.appendingPathComponent("Store.sqlite")
    }
    
    lazy var managedObjectModel : NSManagedObjectModel = {
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        try? coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        return coordinator
    }()
    
    lazy var readContext : NSManagedObjectContext = {
        var readContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        readContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        readContext.mergePolicy = NSOverwriteMergePolicy
        return readContext
    }()
    
    lazy var saveContext : NSManagedObjectContext = {
        var saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.parent = self.readContext
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    func trySave(context : NSManagedObjectContext) {
        if context.hasChanges {
            try? context.save()
            if let contextParent = context.parent {
                trySave(context: contextParent)
            }
        }
    }
}

