//
//  Task.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//

import Foundation


struct Task: Identifiable {
    var tasksGoal: Goal.ID
    var id: UUID
    var title: String
    var completed: Bool
    var creationDate: Date
    var achievedDate: Date?
    
    
    init(id: UUID,taskGoal: UUID, title: String, completed: Bool = false,creationDate: Date, achievedDate: Date?) {
        self.id = id
        self.tasksGoal = taskGoal
        self.title = title
        self.completed = completed
        self.creationDate = creationDate
        self.achievedDate = achievedDate
    }
   
     func completeToggled() -> Task {
         return Task(id: UUID(), taskGoal: UUID(),title: title, completed: !completed, creationDate: Date(), achievedDate: Date())
    }
    
    
    
    
    mutating func unDoCompleteTask() {
        if achievedDate != nil {
            achievedDate = nil
        }
        if completed {
            completed = false
        }
    }
    
    
    mutating func completeTask() {
        
        if achievedDate == nil {
            achievedDate = Date()
        }
        if !completed {
            completed = true
        }
    }
    
    
    mutating func updateTask(title: String) {
        
        self.title = title
        unDoCompleteTask()
        if creationDate != Date() {
            creationDate = Date()
        }
    }
}

