//
//  Goal.swift
//  Focus On
//
//  Created by Eva  Madarasz on 06/05/2023.
//

import Foundation


struct Goal: Identifiable {
  
    static let maximumTasks = 3
    
    var id: UUID
    
    private var goalTasks: [Task]
    private var goalTitle: String
    private var goalCompleted: Bool
    private var goalCreationDate: Date
    private var goalAchievedDate: Date?
    var title: String { goalTitle }
    var tasks: [Task] { goalTasks }
    var completed: Bool { goalCompleted }
    var creationDate: Date { goalCreationDate }
    var achievedDate: Date? { goalAchievedDate}
    
    
    init(id: UUID = UUID(), tasks: [Task], title: String, completed: Bool = false, creationDate: Date, achievedDate: Date? = nil) {
        self.id = id
        self.goalTasks = tasks
        self.goalTitle = title
        self.goalCompleted = completed
        self.goalCreationDate = creationDate
        self.goalAchievedDate = achievedDate
        
    }
    
    
    mutating func addTask(title: String) {
        let newTask = Task(id: UUID(), taskGoal: UUID(), title: title, completed: false, creationDate: Date(), achievedDate: Date())
        goalTasks.append(newTask)
        unCompleteGoal()
    }
    
    private mutating func unCompleteGoal() {
        for i in 0..<goalTasks.count {
            if let taskDate =  goalTasks[i].achievedDate,
               let goalDate = goalAchievedDate,
               taskDate >= goalDate {
                goalTasks[i].unDoCompleteTask()
            }
        }
        
        goalCompleted = false
        goalAchievedDate = nil
    }
    
    mutating func completeGoal() {
        guard !goalTasks.isEmpty else {
            unCompleteGoal()
            return
        }
        
        if goalAchievedDate == nil {
            goalAchievedDate = Date()
        }
        
        if goalCompleted == false {
            goalCompleted = true
        }
        
        for i in 0..<goalTasks.count {
            goalTasks[i].completeTask()
        }
        
    }
    
    mutating func update(title: String) {
        goalTitle = title
        
    }
    
    
    
    mutating func undoCompleteGoal() {
        
        unCompleteGoal()
    }
    
    
    mutating func deleteTask(id: UUID) {
        
        guard let foundIndex  = goalTasks.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        goalTasks.remove(at: foundIndex)
        
    }
    
    mutating func updateTask(id: UUID, title: String) {
        guard let foundIndex  = goalTasks.firstIndex(where: {$0.id == id}) else {
            return
        }

        goalTasks[foundIndex].updateTask(title: title)
            undoCompleteGoal()
        
       
    }
    
    
    mutating func undoCompleteTask(id: UUID) {
        guard let foundIndex  = goalTasks.firstIndex(where: {$0.id == id}) else {
            return
        }
            goalTasks[foundIndex].unDoCompleteTask()
            undoCompleteGoal()
        
    }
    
    mutating func completeTask(id: UUID) {
        guard let foundIndex  = goalTasks.firstIndex(where: {$0.id == id}) else {
            return
        }
            goalTasks[foundIndex].completeTask()
            if allTasksAchieved() {
                completeGoal()
            }
        
    }
    
    func allTasksAchieved() -> Bool {
        var allTasksAchieved : Bool = false
        
        for i in 0..<goalTasks.count {
            if goalTasks[i].self.completed == true {
                allTasksAchieved = true
            } else {
                allTasksAchieved = false
                break
            }
        }
        return allTasksAchieved
        
    }
}




