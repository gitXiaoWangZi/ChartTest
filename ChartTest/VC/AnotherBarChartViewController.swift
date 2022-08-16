//
//  LineChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts
class AnotherBarChartViewController: UIViewController, ChartViewDelegate {

    var chartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configData()
        view.backgroundColor = .systemBackground
    }

}

extension AnotherBarChartViewController {
    func setupUI() {
        chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400))
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.maxVisibleCount = 60
        chartView.pinchZoomEnabled = false
        chartView.drawBarShadowEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
                
        chartView.legend.enabled = false
        
        view.addSubview(chartView)
    }
    
    func configData() {
        let yVals = (0..<5).map { (i) -> BarChartDataEntry in
            let mult = 90.0 + 1
            let val = Double(arc4random_uniform(UInt32(mult))) + mult/3
            return BarChartDataEntry(x: Double(i), y: val)
        }
        
        var set1: BarChartDataSet! = nil
        if let set = chartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1?.replaceEntries(yVals)
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "Data Set")
            set1.colors = ChartColorTemplates.vordiplom()
            set1.drawValuesEnabled = true
            
            
            let data = BarChartData(dataSet: set1)
            
//            chartView.animate(xAxisDuration: 3)
            chartView.animate(yAxisDuration: 3)
//            chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
            chartView.data = data
            chartView.fitBars = true
        }
//        for set in chartView.data!.dataSets {
//            if let set = set as? BarChartDataSet {
//                set.barBorderWidth = set.barBorderWidth == 1.0 ? 0.0 : 1.0
//            }
//        }
        chartView.setNeedsDisplay()
    }
    
    //extension DemoBaseViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("\(scaleX)====\(scaleY)")
        chartView.scalesLargeContentImage = false
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("\(dX)====\(dY)")
    }
}
