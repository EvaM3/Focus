//
//  DateFormattingHelper.swift
//  Focus On
//
//  Created by Eva Madarasz on 06/05/2023.
//

import Foundation

struct DateFormattingHelper {
    
    
    private let goalSectionDateFormatter = DateFormatter()
    private let summarySectionDateFormatter = DateFormatter()
    private let todayString = "Today"
    
    
    init() {
        self.goalSectionDateFormatter.dateFormat = "dd. MM. yyyy"
        self.summarySectionDateFormatter.dateFormat = "MM/yyyy"
        
    }
    
    
    func makeFormattedExactDate(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return todayString
        } else {
            return goalSectionDateFormatter.string(from: date)
        }
        
    }
    
    func makeFormattedSummaryDate(date: Date) -> String {
        
        summarySectionDateFormatter.string(from: date)
    }
    
    
}
