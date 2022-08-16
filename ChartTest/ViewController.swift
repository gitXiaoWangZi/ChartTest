//
//  ViewController.swift
//  ChartTest
//
//  Created by 刘圣洁 on 2022/8/13.
//

import UIKit
import Charts

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
class ViewController: UIViewController {

    let cellId : String = "cellID"
    let data = [AnotherBarChartViewController.self,BarChartViewController.self,BubbleChartViewController.self,CandleStickChartViewController.self,ColoredLineChartViewController.self,CombinedChartViewController.self,CubicLineChartViewController.self,HalfPieChartViewController.self,HorizontalBarChartViewController.self,LineChart1ViewController.self,LineChart2ViewController.self,LineChartFilledViewController.self,LineChartTimeViewController.self,MultipleLinesChartViewController.self,MultipleBarChartViewController.self,NegativeStackedBarChartViewController.self,PieChartViewController.self,PiePolylineChartViewController.self,PositiveNegativeBarChartViewController.self,RadarChartViewController.self,ScatterChartViewController.self,SinusBarChartViewController.self,StackedBarChartViewController.self]
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero,style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }


}

extension ViewController {
    func setupUI() {
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        view.addSubview(tableView)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = NSStringFromClass(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcClass = data[indexPath.row]
        let vc = vcClass.init()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
