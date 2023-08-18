//
//  HistoryListViewController.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import UIKit

class HistoryListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    
    
    var listModel: HistoryListModelProtocol = HistoryListModel(dataManager: CoreDataManager())
    
    
    
    override func viewDidLoad() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "GoalHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "goalcell")
        tableview.register(UINib(nibName: "TaskHistoryTableViewCell",bundle: nil), forCellReuseIdentifier: "taskcell")
        tableview.register(UINib(nibName: "SummaryCell",bundle: nil), forCellReuseIdentifier: "summarycell")
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.listModel.loadData()
            self.tableview.reloadData()
        }
       
    }
  
}

    // MARK: Tableview functions:
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  listModel.sectionRows[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let element = listModel.sectionRows[indexPath.section][indexPath.row]
        
        switch element.type {
        
        case .goal:
            if let cell: GoalHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "goalcell", for: indexPath) as? GoalHistoryTableViewCell {
                cell.configureCheckMarkedCell(item: element)
                return cell
            }
            
        case .task:
            if let cell: TaskHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskcell", for: indexPath) as? TaskHistoryTableViewCell {
                cell.configureCheckMarkedCell(item: element)
                return cell
            }
        
        case .summary:
            if let cell: SummaryCell = tableView.dequeueReusableCell(withIdentifier: "summarycell", for: indexPath) as? SummaryCell {
                cell.configureSummaryCell(item: element)
                return cell
            }

            if indexPath.row == 1 {
                let cell:GoalHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "goalcell", for: indexPath) as! GoalHistoryTableViewCell
                cell.configureCheckMarkedCell(item: element)
                cell.textLabel?.text = element.title
                return cell

            } else {
                let cell: TaskHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "taskcell", for: indexPath) as! TaskHistoryTableViewCell
                cell.configureCheckMarkedCell(item: element)
                cell.textLabel?.text = element.title
                return cell
            }
         
        
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element = listModel.sectionRows[indexPath.section][indexPath.row]
        switch element.type {
        case .goal:
            return 60
            
        case .task:
            return 40
          
        case .summary:
            return 70
        }
    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listModel.sections.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 0
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = headerView.frame
        label.text = self.listModel.sections[section]
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemBlue
        headerView.addSubview(label)
        dump(label)

        return headerView
       
    }

}




