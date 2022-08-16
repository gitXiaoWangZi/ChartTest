//
//  PositiveNegativeBarChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class PositiveNegativeBarChartViewController: UIViewController, IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dataLabels[min(max(Int(value), 0), dataLabels.count - 1)]
    }
    

    var chartView: BarChartView!
    
    let dataLabels = ["12-19",
                      "12-30",
                      "12-31",
                      "01-01",
                      "01-02"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData()
    }

}

extension PositiveNegativeBarChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))

        chartView.chartDescription!.enabled = false
                
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        
        chartView.rightAxis.enabled = false

        chartView.delegate = self
        
        chartView.setExtraOffsets(left: 70, top: -30, right: 70, bottom: 10)
    
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        chartView.chartDescription!.enabled = false
        
        chartView.rightAxis.enabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 13)
        xAxis.drawAxisLineEnabled = false
        xAxis.labelTextColor = .lightGray
        xAxis.labelCount = 5
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        let leftAxis = chartView.leftAxis
        leftAxis.drawLabelsEnabled = false
        leftAxis.spaceTop = 0.25
        leftAxis.spaceBottom = 0.25
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawZeroLineEnabled = true
        leftAxis.zeroLineColor = .gray
        leftAxis.zeroLineWidth = 0.7
        
        view.addSubview(chartView)
    }
    
    
    func configData() {
        let yVals = [BarChartDataEntry(x: 0, y: -224.1),
                     BarChartDataEntry(x: 1, y: 238.5),
                     BarChartDataEntry(x: 2, y: 1280.1),
                     BarChartDataEntry(x: 3, y: -442.3),
                     BarChartDataEntry(x: 4, y: -2280.1)
        ]
        
        let red = UIColor(red: 211/255, green: 74/255, blue: 88/255, alpha: 1)
        let green = UIColor(red: 110/255, green: 190/255, blue: 102/255, alpha: 1)
        let colors = yVals.map { (entry) -> NSUIColor in
            return entry.y > 0 ? red : green
        }
        
        let set = BarChartDataSet(entries: yVals, label: "Values")
        set.colors = colors
        set.valueColors = colors
        
        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 13))
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        data.barWidth = 0.8
        
        chartView.data = data
    }
}
