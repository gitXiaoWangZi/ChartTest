//
//  BarChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    var chartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData()
    }

}

extension BarChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.chartDescription!.enabled = false
                
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        
        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        chartView.maxVisibleCount = 60
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .top
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = (DayAxisValueFormatter(chart: chartView) as? IAxisValueFormatter)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " $"
        leftAxisFormatter.positiveSuffix = " $"
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 8
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
//        chartView.legend = l

        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: chartView.xAxis.valueFormatter!)
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        chartView.marker = marker
        
        view.addSubview(chartView)
    }
    
    func configData() {
        let start = 1
        
        let yVals = (start..<start+10+1).map { (i) -> BarChartDataEntry in
            let mult = 100 + 1
            let val = Double(arc4random_uniform(UInt32(mult)))
            if val < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(systemName: "person"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            chartView.data = data
        }
    }
}
