//
//  LineChartTimeViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class LineChartTimeViewController: UIViewController {

    var chartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData(20, range: 20)
    }

}

extension LineChartTimeViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = LineChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.delegate = self
        
        chartView.chartDescription!.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = true
        
        chartView.backgroundColor = .white
        
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter() as? IAxisValueFormatter
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .insideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 170
        leftAxis.yOffset = -9
        leftAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)

        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line

        view.addSubview(chartView)
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    func configData(_ count: Int, range: UInt32) {
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        
        let from = now - (Double(count) / 2) * hourSeconds
        let to = now + (Double(count) / 2) * hourSeconds
        
        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(range) + 50
            return ChartDataEntry(x: x, y: Double(y))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.fillAlpha = 0.26
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        chartView.data = data
    }
}
