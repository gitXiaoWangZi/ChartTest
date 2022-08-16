//
//  ColoredLineChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class ColoredLineChartViewController: UIViewController {

    var chartView1: LineChartView!
    var chartView2: LineChartView!
    var chartView3: LineChartView!
    var chartView4: LineChartView!
    var chartViews: [LineChartView]!
    var colors: [UIColor]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        colors = [UIColor(red: 137/255, green: 230/255, blue: 81/255, alpha: 1),
                      UIColor(red: 240/255, green: 240/255, blue: 30/255, alpha: 1),
                      UIColor(red: 89/255, green: 199/255, blue: 250/255, alpha: 1),
                      UIColor(red: 250/255, green: 104/255, blue: 104/255, alpha: 1)]
        
        setupUI()
    }

}

extension ColoredLineChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView1 = LineChartView(frame: CGRect(x: 25, y: 0, width: kScreenWidth-50, height: kScreenHeight/4 - 50))
        chartView2 = LineChartView(frame: CGRect(x: 25, y: kScreenHeight/4, width: kScreenWidth-50, height: kScreenHeight/4 - 50))
        chartView3 = LineChartView(frame: CGRect(x: 25, y: kScreenHeight/2, width: kScreenWidth-50, height: kScreenHeight/4 - 50))
        chartView4 = LineChartView(frame: CGRect(x: 25, y: kScreenHeight*3/4, width: kScreenWidth-50, height: kScreenHeight/4 - 50))
        view.addSubview(chartView1)
        view.addSubview(chartView2)
        view.addSubview(chartView3)
        view.addSubview(chartView4)
        chartViews = [chartView1,chartView2,chartView3,chartView4]
        
        for (i, chartView) in chartViews.enumerated() {
            let data = dataWithCount(36, range: 100)
            data.setValueFont(UIFont(name: "HelveticaNeue", size: 17)!)
            
            setupChart(chartView, data: data, color: colors[i % colors.count])
        }
    }
    
    func setupChart(_ chart: LineChartView, data: LineChartData, color: UIColor) {
        (data.dataSets.first as! LineChartDataSet).circleHoleColor = color
        
        chart.delegate = self
        chart.backgroundColor = color
        
        chart.chartDescription!.enabled = false
        
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = false
        chart.setViewPortOffsets(left: 10, top: 0, right: 10, bottom: 0)
        
        chart.legend.enabled = false
        
        chart.leftAxis.enabled = false
        chart.leftAxis.spaceTop = 0.4
        chart.leftAxis.spaceBottom = 0.4
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false
        
        chart.data = data
        
        chart.animate(xAxisDuration: 2.5)
    }
    
    func dataWithCount(_ count: Int, range: UInt32) -> LineChartData {
        let yVals = (0..<count).map { i -> ChartDataEntry in
            let val = Double(arc4random_uniform(range)) + 3
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: yVals, label: "DataSet 1")
        
        set1.lineWidth = 1.75
        set1.circleRadius = 6.0
        set1.circleHoleRadius = 2.5
        set1.setColor(.red)
        set1.setCircleColor(.blue)
        set1.highlightColor = .green
        set1.drawValuesEnabled = false
        
        return LineChartData(dataSet: set1)
    }
}
