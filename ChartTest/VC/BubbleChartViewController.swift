//
//  BubbleChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

class BubbleChartViewController: UIViewController {

    var chartView: BubbleChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData()
    }

}

extension BubbleChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = BubbleChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.delegate = self
        
        chartView.chartDescription!.enabled = true
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        view.addSubview(chartView)
    }
    
    func configData() {
        let yVals1 = (0..<20).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(20)))
            let size = CGFloat(arc4random_uniform(UInt32(20)))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: UIImage(named: "icon"))
        }
        let yVals2 = (0..<20).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(20))+20)
            let size = CGFloat(arc4random_uniform(UInt32(20)))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size, icon: UIImage(named: "icon"))
        }
        let yVals3 = (0..<20).map { (i) -> BubbleChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(20))+40)
            let size = CGFloat(arc4random_uniform(UInt32(20)))
            return BubbleChartDataEntry(x: Double(i), y: val, size: size)
        }
        
        let set1 = BubbleChartDataSet(entries: yVals1, label: "DS 1")
        set1.drawIconsEnabled = true
        set1.setColor(ChartColorTemplates.colorful()[0], alpha: 0.5)
        set1.drawValuesEnabled = true
        
        let set2 = BubbleChartDataSet(entries: yVals2, label: "DS 2")
        set2.drawIconsEnabled = false
        set2.iconsOffset = CGPoint(x: 0, y: 15)
        set2.setColor(ChartColorTemplates.colorful()[1], alpha: 0.5)
        set2.drawValuesEnabled = true
        
        let set3 = BubbleChartDataSet(entries: yVals3, label: "DS 3")
        set3.setColor(ChartColorTemplates.colorful()[4], alpha: 0.5)
        set3.drawValuesEnabled = true
        
        let data = BubbleChartData(dataSets: [set1,set2,set3])
        data.setDrawValues(false)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 7)!)
        data.setHighlightCircleWidth(1.5)
        data.setValueTextColor(.white)
        
        chartView.data = data
    }
}
