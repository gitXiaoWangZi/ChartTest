//
//  HalfPieChartViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/15.
//

import UIKit
import Charts

let parties = ["Party A", "Party B", "Party C", "Party D", "Party E", "Party F",
               "Party G", "Party H", "Party I", "Party J", "Party K", "Party L",
               "Party M", "Party N", "Party O", "Party P", "Party Q", "Party R",
               "Party S", "Party T", "Party U", "Party V", "Party W", "Party X",
               "Party Y", "Party Z"]

class HalfPieChartViewController: UIViewController {

    var chartView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        configData(20, range: 20)
    }

}

extension HalfPieChartViewController: ChartViewDelegate {
    
    func setupUI() {
        chartView = PieChartView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 400))
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.58
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription!.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawCenterTextEnabled = true
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Charts\nby 刘圣洁")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
        chartView.centerAttributedText = centerText;
        
        chartView.holeColor = .white
        chartView.transparentCircleColor = NSUIColor.white.withAlphaComponent(0.43)
        
        chartView.maxAngle = 360 // Half chart
        chartView.centerTextOffset = CGPoint(x: 0, y: -20)
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0 // Rotate to make the half on the upper side
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
//        chartView.legend = l
        
        view.addSubview(chartView)
    }
    
    func configData(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
            return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
                                     label: parties[i % parties.count])
        }
        
        let set = PieChartDataSet(entries: entries, label: "Election Results")
        set.sliceSpace = 3
        set.selectionShift = 5
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 11)!)
        data.setValueTextColor(.white)
        
        chartView.data = data
        
        chartView.setNeedsDisplay()
    }
}

