//
//  TaskViewController.swift
//  Focus On
//
//  Created by Eva Sira Madarasz on 06/05/2023.
//

import UIKit


protocol TaskViewControllerDelegate: AnyObject {
    func taskViewController(_ vc: TaskViewController, didSaveTodo todo: Task)
}

class TaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var todo: Task?
    weak var delegate: TaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textField.text = todo?.title
    }
    
    @IBAction func add(_ sender: Any) {
      performSegue(withIdentifier: "todaySegue", sender: self)
        
    }
    
    

    @IBAction func save(_ sender: UIButton) {
        
     
        let todo = Task(id: UUID(), taskGoal: UUID(), title: textField.text!, completed: false, creationDate: Date(), achievedDate: Date())
        delegate?.taskViewController(self, didSaveTodo: todo)
        
        
    }
    
  

}

