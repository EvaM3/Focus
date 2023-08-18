//
//  GoalViewController.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//

import UIKit



protocol GoalViewControllerDelegate: AnyObject {
    func goalViewController(_ vc: GoalViewController, didSaveGoal goaltodo: GoalEntity)
}



class GoalViewController: UIViewController {
    
    
    @IBOutlet weak var textfield: UITextField!
    
 
    @IBOutlet weak var save: UIButton!
    
    
    var todaysGoal: GoalEntity?
    
    
    
    weak var delegate: GoalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.text = todaysGoal?.title
        
        
    }
    
 
    
    @IBAction func save(_ sender: Any) {
    
       // let todaysGoal = Goal(id: UUID(), tasks: [Task](), title: "Bake the cake", completed: false, creationDate: Date(), achievedDate: Date())
        delegate?.goalViewController(self, didSaveGoal: todaysGoal!)

    }
    
    
}
