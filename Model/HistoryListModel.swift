//
//  HistoryListModel.swift
//  Focus On
//
//  Created by Eva Madarasz on 24/07/2023.
//

import Foundation
import UIKit
import CoreData


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
        
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        for goal in sortedGoals {
            if self.currentSummaryYearAndMonth == nil {
                self.currentSummaryYearAndMonth = dateFormattingHelper.makeFormattedSummaryDate(date: goal.creationDate)
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
        generatedSections.append(self.currentSummaryYearAndMonth ?? "")
        generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
        resetStats()
        self.sections = generatedSections.reversed()
        self.sectionRows = generatedRows.reversed()
        
    }
    
    
}

}
