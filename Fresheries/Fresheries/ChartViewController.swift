//
//  ChartViewController.swift
//  Fresheries
//
//  Created by Manav Ramesh on 2/20/16.
//  Copyright © 2016 Manav Ramesh. All rights reserved.
//

import UIKit
import Charts


class ChartViewController: UIViewController {
    var days:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...7{
            let tempDay = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -7+i, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "M/d"
            days.append(dateFormatter.stringFromDate(tempDay))
        }
        
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        setChart(days, values: unitsSold)
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var scatterPlotView: ScatterChartView!
    
    func setChart(dataPoints: [String], values: [Double]) {
        print("set chart")
        scatterPlotView.noDataText = "You need to provide data for the chart."
        scatterPlotView.rightAxis.drawLabelsEnabled = false
        scatterPlotView.leftAxis.drawLabelsEnabled = false
        scatterPlotView.rightAxis.drawGridLinesEnabled = false
        scatterPlotView.leftAxis.drawGridLinesEnabled = false
        scatterPlotView.leftAxis.drawAxisLineEnabled = false
        scatterPlotView.rightAxis.drawAxisLineEnabled = false
        scatterPlotView.xAxis.labelPosition = ChartXAxis.XAxisLabelPosition.BottomInside
        scatterPlotView.descriptionText = ""
        scatterPlotView.legend.enabled = false
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = ScatterChartDataSet(yVals: dataEntries, label: "eaten")
        chartDataSet.scatterShape = ScatterChartDataSet.ScatterShape(rawValue: 2)!
        let chartData = ScatterChartData(xVals: days, dataSet: chartDataSet)
        //        chartData.
        scatterPlotView.data = chartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

