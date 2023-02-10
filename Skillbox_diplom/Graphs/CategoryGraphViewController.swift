//
//  CategoryGraphViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 2.02.23.
//

import UIKit
import Charts

class CategoryGraphViewController: UIViewController, AxisValueFormatter {
    
    var expences: [Expences] = []
    var expencesForChart: [(date: Date, amount: Double)] = []
    
    weak var axisFormatDelegate: AxisValueFormatter?
    
    @IBOutlet var periodSegments: UISegmentedControl!
    @IBOutlet var graph: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        createExpenceForChart()
        createChart(for: .now.allPeriod)
        periodSegments.setUp()
        periodSegments.addTarget(self, action: #selector(changeGraph), for: .valueChanged)
    }
    
    func createExpenceForChart() {
        for element in expences {
            let tuple = (date: element.date?.startDay ?? .now, amount: element.amount)
            if let index = expencesForChart.firstIndex(where: { $0.date == tuple.date}) {
                expencesForChart[index].amount += tuple.amount
            } else {
                expencesForChart.append(tuple)
            }
        }
    }
    
    func createChart(for date: Date) {
        let filteredArray = expencesForChart.filter({date < $0.date})
        var expenceChartDataEntrys: [ChartDataEntry] = []
        for element in 0..<filteredArray.count {
            let timeIntervalForDate: TimeInterval = (filteredArray[element].date.timeIntervalSince1970) + TimeInterval(TimeZone.current.secondsFromGMT())
            let dataEntry = ChartDataEntry(x: Double(timeIntervalForDate), y: filteredArray[element].amount)
            expenceChartDataEntrys.append(dataEntry)
        }
        let expenceChartDataSet = LineChartDataSet(entries: expenceChartDataEntrys, label: "Расход")
        expenceChartDataSet.colors = [NSUIColor.systemRed]
        let chartData = LineChartData(dataSet: expenceChartDataSet)
        graph.data = chartData
        expenceChartDataSet.circleRadius = 3
        expenceChartDataSet.circleColors = [NSUIColor.systemRed]
        let xAxis = graph.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelPosition = .bottom
        xAxis.gridColor = UIColor.systemGray3
        graph.leftAxis.gridColor = UIColor.systemGray3
        graph.backgroundColor = .systemGray4
        graph.rightAxis.enabled = false
    }
    
    @objc func changeGraph(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0: createChart(for: .now.weekPeriod)
        case 1: createChart(for: .now.monthPeriod)
        case 2: createChart(for: .now.quarterPeriod)
        case 3: createChart(for: .now.allPeriod)
        default: break
        }
    }
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM."
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
