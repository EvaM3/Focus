//
//  HistoryListViewController.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import UIKit
import OSLog

let logger = Logger(subsystem: "tora.buke-gmail.com.Focus-On", category: "HistoryListViewController")

extension Date {
    static func customGoalDatetoString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    static func customSummaryDatetoString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
        
    }
    
    func makeFormattedExactDate(date: Date) -> String {
        let todayString = "Today"
        let goalDateFormatter = DateFormatter()
        goalDateFormatter.dateFormat = "dd/MM/yyyy"
        
        if Calendar.current.isDateInToday(date) {
            return todayString
        } else {
            return goalDateFormatter.string(from: date)
        }
        
    }
    
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: "\(day)/\(month)/\(year)") ?? Date()
    }
}



class HistoryListViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var historyGoal: String = ""
    
    var listModel: HistoryListModelProtocol = HistoryListModel(dataManager: CoreDataManager())
    
    var newGoal = [
        Goal(id: UUID(), tasks: [Task](), title: "Finish the app.", completed: false, creationDate: Date.customGoalDatetoString(customString: "27/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Complete the project", completed: false, creationDate: Date.customGoalDatetoString(customString: "28/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Study more", completed: false, creationDate: Date.customGoalDatetoString(customString: "26/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice violin", completed: false, creationDate: Date.customGoalDatetoString(customString: "25/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice piano", completed: false, creationDate: Date.customGoalDatetoString(customString: "24/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Finish the letters", completed: false, creationDate: Date.customGoalDatetoString(customString: "23/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Study russian", completed: false, creationDate: Date.customGoalDatetoString(customString: "29/08/2023"), achievedDate: nil)
    ]
    
    var goals = [[Goal]]()
    
    override func viewDidLoad() {
        dump(historyGoal)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "GoalHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "goalcell")
        tableview.register(UINib(nibName: "TaskHistoryTableViewCell",bundle: nil), forCellReuseIdentifier: "taskcell")
        tableview.register(UINib(nibName: "SummaryCell",bundle: nil), forCellReuseIdentifier: "summarycell")
        
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.listModel.loadData()
            self.tableview.reloadData()
            self.groupGoals()
        }
       
    }
    
    
    func groupGoals() {
        
      let groupedGoals = Dictionary(grouping: newGoal) { (element) -> Date in
          return element.creationDate.reduceToMonthDayYear()
        }
        let sortedKeys = groupedGoals.keys.sorted()
        sortedKeys.forEach { (keys) in
            let values = groupedGoals[keys]
            goals.append(values ?? [])
        }
    }
  
}


    // MARK: Tableview functions:
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return goals[section].count
        listModel.sectionRows[section].count
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

            if indexPath.row == 2 {
                let cell:GoalHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "goalcell", for: indexPath) as! GoalHistoryTableViewCell
                cell.configureCheckMarkedCell(item: element)
                let historygoal = goals[indexPath.section][indexPath.row]
                cell.textLabel?.text = historygoal.title
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
      //  return goals.count
        self.listModel.sections.count
        
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .blue
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
        
    }
    
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
          if let firstMessageInSection = goals[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
              let dateString = dateFormatter.string(from: firstMessageInSection.creationDate)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
            
        }
        return nil
    }
}





