//
//  ProgressViewController.swift
//  Focus On
//
//  Created by Eva Sira Madarasz on 27/07/2023.
//

import UIKit
import Charts

class ProgressViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createChart()
    }

    private func createChart() {
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        // Configure the axis
        let xAxis = barChart.xAxis
        let rightAxis = barChart.rightAxis
        // Configure legend
        let legend = barChart.legend
        // Supply data
        var entries = [BarChartDataEntry]()
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x),
                                             y: Double.random(in: 0...30))
            )
        }
        let set = BarChartDataSet(entries: entries, label: "Progress")
        set.colors = ChartColorTemplates.liberty()
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
                           
        view.addSubview(barChart)
        barChart.center = view.center
    }
    

   
}
