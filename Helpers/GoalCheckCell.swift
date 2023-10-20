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

    class GoalCheckCell: UITableViewCell, UITextViewDelegate {

        

        @IBOutlet weak var goalText: UITextView!
        
        
        @IBOutlet weak var goalCheckbox: GoalCheckbox!
        
    
        @IBAction func checked(_ sender: GoalCheckbox) {
            updateChecked()
            delegate?.goalCheckCell(self, didChangeCheckedState: goalCheckbox.checked)
        }
        
        weak var delegate: GoalCheckCellDelegate?
        
        
       static let identifier = "goalCell"
        
        func goalPlaceholder() {
            goalText.text = "Your goal for today...Go, rock on!"
            goalText.textColor = UIColor.lightGray
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if goalText.textColor == UIColor.lightGray {
                goalText.text = nil
                goalText.textColor = UIColor.black
            }
        }
        
       
        
        func set(title: String, checked: Bool) {
            goalText.text = title
            goalCheckbox.checked = checked
            updateChecked()
        }
        
        func set(checked: Bool) {
            goalCheckbox.checked = checked
            updateChecked()
        }
      
        private func updateChecked() {
            let attributedString = NSMutableAttributedString(string:  goalText.text!)
            
            if goalCheckbox.checked {
              attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
            } else {
              attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
            }
            
            goalText.attributedText = attributedString
          }
         
         
    }


