//
//  CheckTableViewCell.swift
//  Focus On
//
//  Created by  Madarasz on 06/05/2023.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool)
}


class CheckTableViewCell: UITableViewCell {



    
    @IBOutlet weak var taskText: UITextView!
    
    
    @IBOutlet weak var checkbox: Checkbox!
   
   
    
    @IBAction func checked(_ sender: Checkbox) {
        updateChecked()
        delegate?.checkTableViewCell(self, didChangeCheckedState: checkbox.checked)
    }
   
    
    
    static let identifier = "taskCell"
    
    weak var delegate: CheckTableViewCellDelegate?
    
    
    func taskPlaceholder() {
        taskText.text = "Your task"
        taskText.textColor = UIColor.lightGray
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskText.textColor == UIColor.lightGray {
            taskText.text = nil
            taskText.textColor = UIColor.black
        }
    }
   
    func set(title: String, checked: Bool) {
    taskText.text = title
        checkbox.checked = checked
        updateChecked()
    }
    
    func set(checked: Bool) {
        checkbox.checked = checked
        updateChecked()
    }
  
    private func updateChecked() {
        let attributedString = NSMutableAttributedString(string: taskText.text!)
        
        if checkbox.checked {
          attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
        } else {
          attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
        }
        
    taskText.attributedText = attributedString
      }
     
    
    
}
