//
//  DataController.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//
import UIKit
import CoreData

protocol CoreDataLoaderProtocol {
    func loadGoal(predicate: NSPredicate?) -> [Goal]
    func mapToGoal(entity: GoalEntity) -> Goal 
}

protocol CoreDataUpdaterProtocol {
    func saveGoal(goal: Goal)
    func updateGoal(goal: Goal)
    func deleteGoal(id: UUID)
}




class CoreDataManager: CoreDataLoaderProtocol, CoreDataUpdaterProtocol {
    
  //  let context = DataManager.sharedManager.persistentContainer.viewContext
  //  var commitPredicate: NSPredicate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func saveData() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    func loadGoal(predicate: NSPredicate? = nil) -> [Goal] {
        let goalEntities = loadGoalEntities(predicate: predicate)
        let goals = goalEntities.map { goalEntity in
            mapToGoal(entity: goalEntity)
    
        }
        return goals
    }
    
    private func loadGoalEntities(predicate: NSPredicate? = nil) -> [GoalEntity] {
        let request : NSFetchRequest<GoalEntity> =  GoalEntity.fetchRequest()
       // let date = NSDate()
       // let predicate = NSPredicate(format: " creationDate > %@")
        //predicate.evaluate(with: date)
      //  request.predicate = predicate
        
        do {
            let goalEntities = try context.fetch(request)
            
            return goalEntities
        } catch {
            print("Error loading data \(error)")
            return []
        }
    }
    
    private func loadTaskEntities(predicate: NSPredicate? = nil) -> [TaskEntity] {
        let request : NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = predicate
        do {
            let taskEntities = try context.fetch(request)
            
            return taskEntities
        } catch {
            print("Error loading data \(error)")
            return []
        }
    }
    
   
    
    
    
    func saveGoal(goal: Goal) {
        dump(goal.id)
        guard (existingGoalEntity(id: goal.id) == nil) else {
            return
        }
        
        let _ = mapToGoalEntity(goal: goal)
        saveData()
        
    }
    
    
    func updateGoal(goal: Goal) {
        guard var existingGoal = existingGoalEntity(id: goal.id) else {
            return
        }
        existingGoal.completed = goal.completed
        existingGoal.title = goal.title
        existingGoal.achievedDate = goal.achievedDate
        
        let existingTasks : [TaskEntity] = existingGoal.tasks?.mutableArrayValue(forKey: "tasks") as? [TaskEntity] ?? []
        let existingTaskIds = Set(existingTasks.compactMap { $0.id })
        // same for the goal
        // Intersect the two sets , will have the task ids, which needs to be updated, for each one call // // updateTaskEntity with the goals task   2: Set subtracts to figure out which task needs to be deleted, which one needs to be added. Then update goaltasks as well in existingGoal.
       // let updatedGoal : [GoalEntity] =
    }
    
    
    
    func deleteGoal(id: UUID) {
        
        guard let existingGoal = existingGoalEntity(id: id) else {
            return
        }
        do {
            context.delete(existingGoal)
        }
    }
    
    
    func deleteTask(id: UUID) {
        
        guard let existingTask = existingTaskEntity(id: id) else {
            return
        }
        do {
            context.delete(existingTask)
        }
    }
    
    
    private func existingGoalEntity(id: UUID) -> GoalEntity? {
        let existingGoals = loadGoalEntities()
        guard let existingGoal = existingGoals.first(where: { $0.id == id }) else {
            return nil
        }
        return existingGoal
    }
    
    
    private func existingTaskEntity(id: UUID) -> TaskEntity? {
        let existingTasks = loadTaskEntities()
        guard let existingTask = existingTasks.first(where: { $0.taskID == id }) else {
            return nil
        }
        return existingTask
       
    }
    
    
    func createTask(task: Task) {
        guard (existingTaskEntity(id: task.id) == nil) else {
            return
        }
        
        let _ = mapToTaskEntity(item: task)
    }
    
    
    func updateTask(task: Task) {
        guard var existingTask = existingTaskEntity(id: task.id) else {
            return
        }
        existingTask.completed = task.completed
        existingTask.title = task.title
        existingTask.achievedDate = task.achievedDate
    }
    
    
    func mapToGoal(entity: GoalEntity) -> Goal {
        var goalTasks: [Task] = []
        if let tasks = entity.tasks?.mutableArrayValue(forKey: "tasks") as? [TaskEntity] {
            for task in tasks {
                let newTask: Task = Task(id: task.taskId, taskGoal: UUID(), title: task.taskName ?? "Unknown", completed: task.completed, creationDate: task.taskCreationDate ?? Date(), achievedDate: task.taskAchievedDate)
                goalTasks.append(newTask)
            }
        }
        let goal: Goal = Goal(id: entity.defaultId , tasks: goalTasks, title: entity.defaultTitle, completed: entity.isCompleted, creationDate: entity.defaultCreationDate, achievedDate: entity.defaultAchievedDate)
        
        return goal
    }
    
    
    func mapToGoalEntity(goal: Goal) -> GoalEntity {
        var taskEntities: [TaskEntity] = []
        
        for task in goal.tasks {
            let newTaskEntity = mapToTaskEntity(item: task)
            taskEntities.append(newTaskEntity)
        }
        let newGoal = GoalEntity(context: context)
        newGoal.id = goal.id
        newGoal.title = goal.title
        newGoal.creationDate = goal.creationDate
        newGoal.achievedDate = goal.achievedDate
        newGoal.completed = goal.completed
        newGoal.insertIntoTasks(taskEntities, at: NSIndexSet(indexesIn: NSRange(location: 0, length: taskEntities.count)))
        
        return newGoal
    }
    
    
    func mapToTaskEntity(item: Task) -> TaskEntity {
        let newItem = TaskEntity(context: context)
        newItem.taskID = item.id
        newItem.title = item.title
        newItem.creationDate = item.creationDate
        newItem.achievedDate = item.achievedDate
        newItem.completed = item.completed
        
        return newItem
    }
    
 
    
    func getTodaysDate() -> Date {
        let todaysDate = Date()
        return todaysDate
    }
}

