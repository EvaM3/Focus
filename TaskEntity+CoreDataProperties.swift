//
//  TaskEntity+CoreDataProperties.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var goalID: UUID?
    @NSManaged public var achievedDate: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var creationDate: Date?
    @NSManaged public var taskID: UUID?
    @NSManaged public var title: String?

    
    public var defaultGoal: UUID {
           goalID ?? UUID()
        }
        
        public var taskAchievedDate: Date? {
            achievedDate
        }
        
        public var taskCreationDate: Date? {
            creationDate ?? Date()
        }
        
        public var taskName: String? {
        title ?? "Unknown"
    }
    
    public var taskId: UUID {
        taskID ?? UUID()
    }
    
    
    
}

extension TaskEntity : Identifiable {

}
