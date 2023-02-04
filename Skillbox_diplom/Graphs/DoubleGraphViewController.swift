//
//  DoubleGraphViewController.swift
//  Skillbox_diplom
//
//  Created by Aliaksandr Pustahvar on 26.01.23.
//

import UIKit
import Charts

class DoubleGraphViewController: UIViewController, AxisValueFormatter {
    
    weak var axisFormatDelegate: AxisValueFormatter?
    
    var expences: [Expences] = []
    var incomes: [Income] = []
    var incomesForChart: [(date: Date, amount: Double)] = []
    var expencesForChart: [(date: Date, amount: Double)] = []
    @IBOutlet var graph: LineChartView!
    @IBOutlet var periodSegments: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createArraysForChart()
        axisFormatDelegate = self
        createChart(for: .now.allPeriod)
        periodSegments.setUp()
        periodSegments.addTarget(self, action: #selector(changeGraph), for: .valueChanged)
    }
    
    func createChart( for date: Date) {
        let filteredIncomes = incomesForChart.filter({ date < $0.date })
        var incomeChartDataEntrys: [ChartDataEntry] = []
        for element in 0..<filteredIncomes.count {
            let timeIntervalForDate: TimeInterval = (filteredIncomes[element].date.timeIntervalSince1970) + TimeInterval(TimeZone.current.secondsFromGMT())
            let dataEntry = ChartDataEntry(x: Double(timeIntervalForDate), y: filteredIncomes[element].amount)
            incomeChartDataEntrys.append(dataEntry)
        }
        let incomeChartDataSet = LineChartDataSet(entries: incomeChartDataEntrys, label: "Даход")
        incomeChartDataSet.colors = [NSUIColor.systemGreen]
        incomeChartDataSet.lineWidth = 3
        
        let filteredExpences = expencesForChart.filter({ date < $0.date })
        var expenceChartDataEntrys: [ChartDataEntry] = []
        for element in 0..<filteredExpences.count {
            let timeIntervalForDate: TimeInterval = (filteredExpences[element].date.timeIntervalSince1970) + TimeInterval(TimeZone.current.secondsFromGMT())
            let dataEntry = ChartDataEntry(x: Double(timeIntervalForDate), y: filteredExpences[element].amount)
            expenceChartDataEntrys.append(dataEntry)
        }
        let expenceChartDataSet = LineChartDataSet(entries: expenceChartDataEntrys, label: "Расход")
        expenceChartDataSet.colors = [NSUIColor.systemRed]
        expenceChartDataSet.lineWidth = 2
        
        let chartData = LineChartData(dataSets: [incomeChartDataSet,expenceChartDataSet])
        graph.data = chartData
        expenceChartDataSet.circleRadius = 3
        expenceChartDataSet.circleColors = [NSUIColor.systemRed]
        incomeChartDataSet.circleRadius = 3
        incomeChartDataSet.circleColors = [NSUIColor.systemGreen]
        let xAxis = graph.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelPosition = .bottom
        xAxis.gridColor = UIColor.systemGray3
        graph.leftAxis.gridColor = UIColor.systemGray3
        graph.backgroundColor = .systemGray4
        graph.rightAxis.enabled = false
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM."
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    func createArraysForChart() {
        for element in incomes {
            let tuple = (date: element.date?.startDay ?? .now, amount: element.amount)
            if let index = incomesForChart.firstIndex(where: {$0.date == tuple.date}) {
                incomesForChart[index].amount += tuple.amount
            } else {
                incomesForChart.append(tuple)
            }
        }
        
        for element in expences {
            let tuple = (date: element.date?.startDay ?? .now, amount: element.amount)
            if let index = expencesForChart.firstIndex(where: {$0.date == tuple.date}) {
                expencesForChart[index].amount += tuple.amount
            } else {
                expencesForChart.append(tuple)
            }
        }
    }
    
    @objc func changeGraph(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0: createChart(for: .now.week)
        case 1: createChart(for: .now.month)
        case 2: createChart(for: .now.quarter)
        case 3: createChart(for: .now.allPeriod)
        default: break
        }
    }
}

