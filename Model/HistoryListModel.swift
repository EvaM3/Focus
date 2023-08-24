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
    private var currentYearAndMonth: String?
    private var totalGoalsCounter = 0
    private var completedGoalsCounter = 0
  
    
    
    var sections = [String]()
    var sectionRows =  [[ListElement]]()
   
    init(dataManager: CoreDataLoaderProtocol) {
        self.dataManager = dataManager
    }
    
    
    func loadData() {
        //dataManager.generateRandomData()
        generateData(from: dataManager.loadGoal(predicate: nil))
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

  
    private func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        let date = Date()
        
        let sameMonth = Calendar.current.isDate(date, equalTo: date, toGranularity: .month)
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
     
        for goal in sortedGoals {
            if self.currentSummaryYearAndMonth == nil {
                self.currentSummaryYearAndMonth = dateFormattingHelper.makeFormattedSummaryDate(date: goal.creationDate)
                if self.currentSummaryYearAndMonth == currentSummaryYearAndMonth {
                    
                }
                
            } else {
                let currentGoalYearAndMonth = dateFormattingHelper.makeFormattedSummaryDate(date: goal.creationDate)
                if currentSummaryYearAndMonth != currentGoalYearAndMonth,
                   let currentSummaryYearAndMonth = currentSummaryYearAndMonth {
                   
                    let summary = addToSummary()
                    generatedSections.append(summary.yearAndMonth)
                    generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
                    
                    self.currentSummaryYearAndMonth = currentGoalYearAndMonth
                    
                }
           
        }
        
        
        
        
        let summary = addToSummary()
            if currentSummaryYearAndMonth != currentSummaryYearAndMonth {
        generatedSections.append(self.currentSummaryYearAndMonth ?? "")
            }
        generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
        resetStats()
        self.sections = generatedSections.reversed()
        self.sectionRows = generatedRows.reversed()
        
    }
    
    
}

}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    
    
}

extension HistoryListModel {
    
//    extension RangeReplaceableCollection where Element: Hashable {
//        var squeezed: Self {
//            var set = Set<Element>()
//            return filter{ set.insert($0).inserted }
//        }
//    }
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
}

//extension Date {
//func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
//    calendar.isDate(self, equalTo: date, toGranularity: component)
//}
//
//func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
//func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
//func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
//
//func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
//
//var isInThisYear:  Bool { isInSameYear(as: Date()) }
//var isInThisMonth: Bool { isInSameMonth(as: Date()) }
//var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
//
//var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
//var isInToday:     Bool { Calendar.current.isDateInToday(self) }
//var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
//
//var isInTheFuture: Bool { self > Date() }
//var isInThePast:   Bool { self < Date() }
//
//}

  
