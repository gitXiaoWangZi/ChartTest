//
//  HorizontalBarChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class HorizontalBarChartViewController: UIViewController {

    var chartView: HorizontalBarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData(20, range: 20)
    }

}

extension HorizontalBarChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = HorizontalBarChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.chartDescription!.enabled = false
                
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        
        chartView.rightAxis.enabled = false
        chartView.delegate = self
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        chartView.maxVisibleCount = 60
        
        // ChartYAxis *leftAxis = chartView.leftAxis;
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = true
        xAxis.granularity = 10
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.axisMinimum = 0

        let rightAxis = chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.drawAxisLineEnabled = true
        rightAxis.axisMinimum = 0

        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .square
        l.formSize = 8
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
//        chartView.legend = l

        chartView.fitBars = true
        view.addSubview(chartView)
        chartView.animate(yAxisDuration: 2.5)
    }
    
    func configData(_ count: Int, range: UInt32) {
        let barWidth = 9.0
        let spaceForBar = 10.0
        
        let yVals = (0..<count).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            return BarChartDataEntry(x: Double(i)*spaceForBar, y: val, icon: #imageLiteral(resourceName: "icon"))
        }
        
        let set1 = BarChartDataSet(entries: yVals, label: "DataSet")
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        
        chartView.data = data
    }
}
