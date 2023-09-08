//
//  GoalHistoryTableViewCell.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import UIKit

class GoalHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet  var title: UILabel!
    
    @IBOutlet weak var checkMark: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    

    
    func configureCheckMarkedCell(item: ListElement) {
        title.textAlignment = .left
        title.isUserInteractionEnabled = false
        title.text = item.title
      
      
        
        if item.isCompleted {
            checkMark.image =  UIImage(systemName: "checkmark.rectangle.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        } else {
            checkMark.image = UIImage(systemName: "checkmark.rectangle")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        }
    }
    
    
}
