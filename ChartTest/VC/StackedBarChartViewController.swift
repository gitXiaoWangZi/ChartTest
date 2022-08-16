//
//  StackedBarChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class StackedBarChartViewController: UIViewController {
    var chartView: BarChartView!
    
    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.negativeSuffix = " $"
        formatter.positiveSuffix = " $"
        
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData(count: 20, range: 20)
    }

}

extension StackedBarChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))

        chartView.delegate = self
        
        chartView.chartDescription!.enabled = false
        
        chartView.maxVisibleCount = 40
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        chartView.highlightFullBarEnabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .top
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formToTextSpace = 4
        l.xEntrySpace = 6
//        chartView.legend = l
        
        view.addSubview(chartView)
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }
    
    func configData(count: Int, range: UInt32) {
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val1 = Double(arc4random_uniform(mult) + mult / 3)
            let val2 = Double(arc4random_uniform(mult) + mult / 3)
            let val3 = Double(arc4random_uniform(mult) + mult / 3)
            
            return BarChartDataEntry(x: Double(i), yValues: [val1, val2, val3], icon: #imageLiteral(resourceName: "icon"))
        }
        
        let set = BarChartDataSet(entries: yVals, label: "Statistics Vienna 2014")
        set.drawIconsEnabled = false
        set.colors = [ChartColorTemplates.material()[0], ChartColorTemplates.material()[1], ChartColorTemplates.material()[2]]
        set.stackLabels = ["Births", "Divorces", "Marriages"]
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.setValueTextColor(.white)
        
        chartView.fitBars = true
        chartView.data = data
    }
}
