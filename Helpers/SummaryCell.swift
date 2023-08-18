//
//  SummaryCell.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import UIKit

class SummaryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    
    func configureSummaryCell(item: ListElement) {
        title.text = item.title
    }
}
