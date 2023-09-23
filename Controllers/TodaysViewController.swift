//
//  TodaysViewController.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//

import UIKit
import CoreData




class TodaysViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CheckTableViewCellDelegate {
    
    
    
  
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
 
    @IBOutlet weak var tableView: UITableView!
    

   private var dataManager = CoreDataManager()
   private var todaysGoal = [GoalEntity]()
   private var todaysTasks = [TaskEntity]()
        
    
  
    
    var newGoal = [
        Goal(id: UUID(), tasks: [Task](), title: "Finish the app.", completed: false, creationDate: Date(), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Complete the project", completed: false, creationDate: Date(), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Study more", completed: false, creationDate: Date(), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice violin", completed: false, creationDate: Date(), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice piano", completed: false, creationDate: Date(), achievedDate: nil)
    ]
     
    
    var tasks = [
        Task(id: UUID(), taskGoal: UUID(), title: "Finish the book", completed: false,creationDate: Date(), achievedDate: nil),
        Task(id: UUID(), taskGoal: UUID(), title: "Write the essay", completed: false,creationDate: Date(), achievedDate: nil),
        Task(id: UUID(), taskGoal: UUID(), title: "Take a long walk", completed: false,creationDate: Date(), achievedDate: nil),
        Task(id: UUID(), taskGoal: UUID(), title: "Buy flowers", completed: false,creationDate: Date(), achievedDate: nil)
    ]
    
    
    @IBAction func startEditing(_ sender: UIButton) {
        tableView.isEditing = !tableView.isEditing
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGoal()
       
    }
    
    // MARK: Core Data functions
    //*************************************************************x
    
    func getGoal() {
        do {
            todaysGoal = try context.fetch(GoalEntity.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            let alert = UIAlertController(title: "Sorry", message: "Error, goal does not exist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func createGoal(title: String) {
        for _ in todaysGoal {
        let newGoal = GoalEntity(context: context)
        newGoal.title = "Study music"
        newGoal.creationDate = Date()
        }
        do {
            try context.save()
            
            getGoal()
        }  catch {
            
            let alert = UIAlertController(title: "Sorry", message: "Error, could not create goal", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    

    
    func updateGoal(goal: GoalEntity, newGoal: String) {
        goal.title = newGoal
        
        do {
            try context.save()
            getGoal()
            
        } catch  {
            
            let alert = UIAlertController(title: "Sorry", message: "Error, couldn't update goal", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func deleteGoal(goal: GoalEntity) {
        
        context.delete(goal)
        getGoal()
        do {
            
            try context.save()
            getGoal()
            
        } catch  {
            
            let alert = UIAlertController(title: "Sorry", message: "Error, couldn't delete goal", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func getTask() {
        
        do {
           todaysTasks = try context.fetch(TaskEntity.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            let alert = UIAlertController(title: "Sorry", message: "Error, task does not exist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    func updateTask(task: TaskEntity, newTask: String) {
        
        task.title = newTask
        
        do {
            try context.save()
             getTask()
        } catch  {
            
            let alert = UIAlertController(title: "Sorry", message: "Error, couldn't update task", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    func deleteTask(task: TaskEntity) {
        context.delete(task)
    do {
            
        try context.save()
       getTask()
    } catch  {
            
            let alert = UIAlertController(title: "Sorry", message: "Error, couldn't delete task", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    //MARK: Table view functions
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal, title: "Completed") { action, view, complete in
            let todo = self.tasks[indexPath.row].completeToggled()
            self.tasks[indexPath.row] = todo
            
          
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.contentView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.set(checked: todo.completed)
            complete(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count // max(3, tasks.count)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0 & 1) {
            return 180
            
        } else {
            
            return 80
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GoalCheckCell.identifier, for: indexPath) as! GoalCheckCell
        
            cell.delegate = self
            
            let goalForToday = todaysGoal[indexPath.row]
        
        
           cell.set(title: goalForToday.title ?? "Reorder the room", checked: goalForToday.completed)
            
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                  cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
            })
        return cell
            
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier:CheckTableViewCell.identifier, for: indexPath) as! CheckTableViewCell
    
       cell.delegate = self
        
      
        let tasksForToday = tasks[indexPath.row]
        
      //  cell.textLabel?.text = tasksForToday.title
    
        cell.set(title: tasksForToday.title, checked: tasksForToday.completed)
            
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
                UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
                    })
    return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = tasks.remove(at: sourceIndexPath.row)
        tasks.insert(todo, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "history", sender: self)
           }
    }
    
    //MARK: Segue actions
    
    
//    @IBSegueAction func todayGoalvc(_ coder: NSCoder) -> GoalViewController? {
//        let vc = GoalViewController(coder: coder)
//        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let todo = todaysGoal[indexPath.row]
//            vc?.title = todo.title
//        }
//        
//        vc?.delegate = self
//        return vc
//    }
    
    @IBSegueAction func todaysGoalVc(_ coder: NSCoder) -> GoalViewController? {
        let vc = GoalViewController(coder: coder)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let todo = todaysGoal[indexPath.row]
            vc?.title = todo.title
        }
        
        vc?.delegate = self
        return vc
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "history" , let historyVc = segue.destination as? HistoryListViewController {
        let goalForToday = todaysGoal[0]
            historyVc.historyGoal = goalForToday.title!
        super.prepare(for: segue, sender: sender)
        }
        
    }
    
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }

//        let todo = todaysTasks[indexPath.row]
//        let newTodo = Task(id: UUID(), taskGoal: UUID(), title: todo.title ?? "Go for a walk", completed: false,creationDate: Date(), achievedDate: Date())
//
//        todaysTasks[indexPath.row] = dataManager.mapToTaskEntity(item: newTodo)
    }

}

// MARK: Extensions


extension TodaysViewController: GoalCheckCellDelegate {
    func goalCheckCell(_ cell: GoalCheckCell, didChangeCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
         let todo = newGoal[indexPath.row]
        
    }
}

//
//extension TodaysViewController: TaskViewControllerDelegate {
//    func taskViewController(_ vc: TaskViewController, didSaveTodo todo: Task) {
//        dismiss(animated: true) { [self] in
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                self.tasks[indexPath.row] = todo
//                tableView.reloadRows(at: [indexPath], with: .none)
//            } else {
//                self.tasks.append(todo)
//                tableView.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .automatic)
//            }
//        }
//    }
//}

extension TodaysViewController: GoalViewControllerDelegate {
    func goalViewController(_ vc: GoalViewController, didSaveGoal goaltodo: GoalEntity) {
        dismiss(animated: true) { [self] in
            //update
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.todaysGoal[indexPath.row] = goaltodo
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                // create
                self.todaysGoal.append(goaltodo)
                tableView.insertRows(at: [IndexPath(row: tasks.count-1, section: 0)], with: .automatic)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension TodaysViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    
}


    
