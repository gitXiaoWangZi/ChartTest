//
//  CubicLineChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

private class CubicLineSampleFillFormatter: IFillFormatter {
    func getFillLinePosition(dataSet: ILineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
        return -10
    }
}

class CubicLineChartViewController: UIViewController,ChartViewDelegate {

    var chartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData(20, range: 20)
        
    }

}

extension CubicLineChartViewController {
    
    func setupUI() {
        chartView = LineChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.delegate = self

        chartView.setViewPortOffsets(left: 0, top: 20, right: 0, bottom: 0)
        chartView.backgroundColor = UIColor(red: 104/255, green: 241/255, blue: 175/255, alpha: 1)
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.maxHighlightDistance = 300
        
        chartView.xAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size:12)!
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.labelPosition = .insideChart
        yAxis.axisLineColor = .white
        
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        view.addSubview(chartView)
        chartView.animate(xAxisDuration: 2, yAxisDuration: 2)
    }
    
    func configData(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult) + 20)
            return ChartDataEntry(x: Double(i), y: val)
        }

        let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1.8
        set1.circleRadius = 4
        set1.setCircleColor(.white)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.fillColor = .white
        set1.fillAlpha = 1
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.fillFormatter = CubicLineSampleFillFormatter()
        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 9)!)
        data.setDrawValues(false)
        
        chartView.data = data
    }
}
