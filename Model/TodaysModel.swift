//
//  TodaysModel.swift
//  Focus On
//
//  Created by Eva  Madarasz on 06/05/2023.
//

import UIKit


protocol TodayListModel {
    func createGoal(with title: String)
    func addTask(with title: String)
    func loadData()
    func updateGoal(with title: String, completed: Bool)
    func update(taskID: UUID, with title: String, completed: Bool)
    func deleteGoal()
    func deleteTask(taskID: UUID)
}

class TodaysListModel {
    
   private var goal: Goal? = nil
    
    var todaysGoal: Goal? {goal}
    
    
    
    
    func createGoal(with title: String) {
        // checking if there is already a goal, to avoid overriding.
        
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        // Ask DataController to create the goal.
    }
    
    
    func addTask(with title: String) -> Void {
        guard var unwrappedGoal = goal else {
            return
        }
        
        if unwrappedGoal.tasks.count >= Goal.maximumTasks {
            return
        }
        
        unwrappedGoal.addTask(title: title)
        
        goal = unwrappedGoal
        
        // Ask DataController to save to Goal.
        
    }
    
    func loadData() {
        // Is there a goal already loaded, if yes, return.
        // Create filtering for todays goal.
        // Load the goal with the filtering from the data controller.
        // Check if there is a goal for today, if yes, load it.
        // Create a filter for previous goals, load the goals.
        // If there is no goal,but the last goal is not completed yet, offer the old goal.
        // If the user wants to continue with the old goal.
        // Create a new goal from the old goal with todays creationDate, and assign to goal(variable).
        // Ask data controller to update the goal.
        
    }
    
    func updateGoal(with title: String, completed: Bool) {
        
        guard var unwrappedGoal = goal else {
            return
        }
        if unwrappedGoal.title != title {
            unwrappedGoal.update(title: title)
        }
        if unwrappedGoal.completed != completed {
            unwrappedGoal.completed ? unwrappedGoal.undoCompleteGoal() :  unwrappedGoal.completeGoal()
        }
        goal = unwrappedGoal
        // Ask DataController to update the goal.
    }
    
    
    func update(taskID: UUID, with title: String, completed: Bool) {
        
        guard var unwrappedGoal = goal else {
            return
        }
        if unwrappedGoal.title != title {
            unwrappedGoal.update(title: title)
        }
        if unwrappedGoal.id != taskID {
            unwrappedGoal.updateTask(id: taskID, title: title)
        }
        if unwrappedGoal.completed != completed {
            unwrappedGoal.completed ? unwrappedGoal.undoCompleteGoal() :  unwrappedGoal.completeGoal()
        }
        goal = unwrappedGoal
        
        // Ask DataController to update task.
    }
    
    
    func deleteGoal() {
        
        goal = nil
        // Ask DataController to delete the goal.
    }
    
    
    func deleteTask(taskID: UUID) {
        
        guard var unwrappedGoal = goal else {
            return
        }
        unwrappedGoal.deleteTask(id: taskID)
        goal = unwrappedGoal
        
        // Ask DataController to delete the task.
    }
}
