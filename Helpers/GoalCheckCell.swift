//
//  GoalCheckCell.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//



  import UIKit

protocol GoalCheckCellDelegate: AnyObject {
    func goalCheckCell(_ cell: GoalCheckCell, didChangeCheckedState checked: Bool)
}

    class GoalCheckCell: UITableViewCell {

        

        
        @IBOutlet weak var goalLabel: UILabel!
        
        @IBOutlet weak var goalCheckbox: GoalCheckbox!
        
    
        @IBAction func checked(_ sender: GoalCheckbox) {
            updateChecked()
            delegate?.goalCheckCell(self, didChangeCheckedState: goalCheckbox.checked)
        }
        
        weak var delegate: GoalCheckCellDelegate?
        
        
       static let identifier = "goalCell"
        
        func set(title: String, checked: Bool) {
            goalLabel.text = title
            goalCheckbox.checked = checked
            updateChecked()
        }
        
        func set(checked: Bool) {
            goalCheckbox.checked = checked
            updateChecked()
        }
      
        private func updateChecked() {
            let attributedString = NSMutableAttributedString(string:  goalLabel.text!)
            
            if goalCheckbox.checked {
              attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
            } else {
              attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
            }
            
            goalLabel.attributedText = attributedString
          }
         
         
    }


