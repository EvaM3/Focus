//
//  HistoryListModel.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import Foundation
import UIKit
import CoreData
import OSLog

let historylogger = Logger(subsystem: "tora.buke-gmail.com.Focus-On", category: "HistoryListModel")


protocol HistoryListModelProtocol  {
    var sections: [String] { get }
    var sectionRows: [[ListElement]] { get }
    
    func loadData()
}



class HistoryListModel: HistoryListModelProtocol {
    
    
    
    private var dataManager: CoreDataLoaderProtocol
    private let dateFormattingHelper = DateFormattingHelper()
    private var currentSummaryYearAndMonth: String?
    private var currentCreationDate: String?
    private var currentYearAndMonth: String?
    private var currentDay = Date()
    private var totalGoalsCounter = 0
    private var completedGoalsCounter = 0
   
    
    
    var sections = [String]()
    var sectionRows =  [[ListElement]]()
    
    init(dataManager: CoreDataLoaderProtocol) {
        self.dataManager = dataManager
    }
    
    var newGoal = [
        Goal(id: UUID(), tasks: [Task](), title: "Finish the app.", completed: false, creationDate: Date.customGoalDatetoString(customString: "27/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Complete the project", completed: false, creationDate: Date.customGoalDatetoString(customString: "28/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Study more", completed: false, creationDate: Date.customGoalDatetoString(customString: "26/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice violin", completed: false, creationDate: Date.customGoalDatetoString(customString: "25/08/2023"), achievedDate: nil),
        Goal(id: UUID(), tasks: [Task](), title: "Practice piano", completed: false, creationDate: Date.customGoalDatetoString(customString: "24/08/2023"), achievedDate: nil)
    ]
    
    func loadData() {
        //dataManager.generateRandomData()
        generateData(from: dataManager.loadGoal(predicate: nil))
      //  groupGoals()
       
    }
    
    // MARK: Data loading functions
    
    private func mapGoal(goal: Goal) -> [ListElement] {
        var elementArray = [ListElement]()
        let newGoalEntity = ListElement(from: goal)
        elementArray.append(newGoalEntity)
        historylogger.info("Info: \(goal.id)")
        for task in goal.tasks {
            let taskListElement = ListElement(from: task)
            elementArray.append(taskListElement)
        }
        return elementArray
    }
    
    private func addToStats(goal: Goal) {
        totalGoalsCounter += 1
        
        if goal.completed {
            completedGoalsCounter += 1
        }
        
    }
    
    private func resetStats() {
        totalGoalsCounter = 0
        completedGoalsCounter = 0
    }
    
    
    private func addToSummary() -> (yearAndMonth: String, totalCount: Int, completedCount: Int) {
        let summary = (yearAndMonth: currentSummaryYearAndMonth ?? "", totalCount: totalGoalsCounter, completedCount: completedGoalsCounter)
        
        resetStats()
        
        return summary
    }

    
    private func orderedGoals(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        let grouped = from.sliced(by: [.year, .month, .day], for: \.creationDate)
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        
        for goal in sortedGoals {
            if self.currentCreationDate == nil {
                self.currentCreationDate = dateFormattingHelper.makeFormattedExactDate(date: goal.creationDate)
            } else {
                generatedSections.append(currentCreationDate!)
                
                
                addToStats(goal: goal)
                
                generatedRows.append(mapGoal(goal: goal))
                
            }
        }
    }
    
  
    
    
    
    private func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        
    
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        
//        let groupDate = Dictionary(grouping: generatedSections) { (Goal) -> DateComponents in
//            let goal = Goal.self
//            let date = Calendar.current.dateComponents([.day, .year, .month], from: Goal(Goal).goalCreationDate)
//            return date
//        }
        
        for goal in sortedGoals {
            if self.currentSummaryYearAndMonth == nil {
                self.currentSummaryYearAndMonth = dateFormattingHelper.makeFormattedSummaryDate(date: goal.creationDate)
                
            } else {
                let currentGoalYearAndMonth = dateFormattingHelper.makeFormattedSummaryDate(date: goal.creationDate)
                if currentSummaryYearAndMonth != currentGoalYearAndMonth,
                   let currentSummaryYearAndMonth = currentSummaryYearAndMonth {
                   
                  let summary = addToSummary()
                    
                generatedSections.append(summary.yearAndMonth)
                    
                    generatedRows.append(mapGoal(goal: goal))
//                    generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
//
                   self.currentSummaryYearAndMonth = currentGoalYearAndMonth
                    
                    
                }
                
                
                
            }
            
            
            
            
            let summary = addToSummary()
            if currentSummaryYearAndMonth != currentSummaryYearAndMonth {
                generatedSections.append(self.currentSummaryYearAndMonth ?? "")
            }
            generatedRows.append(mapGoal(goal: goal))
//            generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
            resetStats()
            
            self.sections = generatedSections.reversed()
            self.sectionRows = generatedRows.reversed()
            // orderedGoals(from: [goal])
        }
       
        
    }
    
    
   
}



extension Array {
  func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date>) -> [Date: [Element]] {
    let initial: [Date: [Element]] = [:]
    let groupedByDateComponents = reduce(into: initial) { acc, cur in
      let components = Calendar.current.dateComponents(dateComponents, from: cur[keyPath: key])
      let date = Calendar.current.date(from: components)!
      let existing = acc[date] ?? []
      acc[date] = existing + [cur]
    }

    return groupedByDateComponents
  }
}



extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    
    
}



