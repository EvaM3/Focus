//
//  GoalEntity+CoreDataProperties.swift
//  Focus On
//
//  Created by Eva  Madarasz on 06/05/2023.
//
//

import Foundation
import CoreData


extension GoalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalEntity> {
        return NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
    }

    @NSManaged public var achievedDate: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var tasks: TaskEntity?

    var defaultAchievedDate: Date? {
     achievedDate
    }
    
    public var defaultCreationDate: Date {
        creationDate ?? Date()
    }
    
    public var defaultTitle: String {
    title ?? "Unknown"
}
    
   public var defaultId: UUID {
        id ?? UUID()
    }
    
    public var defaultTasks: TaskEntity? {
       tasks
    }
    
    
    public var isCompleted: Bool {
        completed
    }
}




// MARK: Generated accessors for tasks
extension GoalEntity {

    @objc(insertObject:inTasksAtIndex:)
    @NSManaged public func insertIntoTasks(_ value: TaskEntity, at idx: Int)

    @objc(removeObjectFromTasksAtIndex:)
    @NSManaged public func removeFromTasks(at idx: Int)

    @objc(insertTasks:atIndexes:)
    @NSManaged public func insertIntoTasks(_ values: [TaskEntity], at indexes: NSIndexSet)

    @objc(removeTasksAtIndexes:)
    @NSManaged public func removeFromTasks(at indexes: NSIndexSet)

    @objc(replaceObjectInTasksAtIndex:withObject:)
    @NSManaged public func replaceTasks(at idx: Int, with value: TaskEntity)

    @objc(replaceTasksAtIndexes:withTasks:)
    @NSManaged public func replaceTasks(at indexes: NSIndexSet, with values: [TaskEntity])

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: TaskEntity)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: TaskEntity)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSOrderedSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSOrderedSet)

}


extension GoalEntity : Identifiable {

}
