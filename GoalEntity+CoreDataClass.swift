//
//  GoalEntity+CoreDataClass.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//
//

import Foundation
import CoreData

@objc(GoalEntity)
public final class GoalEntity: NSManagedObject {

    public init(context: NSManagedObjectContext,
     achievedDate: Date?,
     completed: Bool,
     creationDate: Date?,
     id: UUID?,
     title: String?,
     tasks: TaskEntity?)
     {
         let entity = NSEntityDescription.entity(forEntityName: "GoalEntity", in: context)!
         super.init(entity: entity, insertInto: context)
         self.achievedDate = achievedDate
         self.completed = completed
         self.creationDate = creationDate
         self.id = id
         self.title = title
         self.tasks = tasks
    }
    @objc
       override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
           super.init(entity: entity, insertInto: context)
       }
}
