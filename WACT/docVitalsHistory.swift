//
//  docVitalsHistory.swift
//  WACT
//
//  Created by Clara on 5/3/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import Foundation
import UIKit
import Charts

class docVitalsHistory: UIViewController {
    @IBOutlet weak var temp: LineChartView!
    @IBOutlet weak var bp: LineChartView!
    @IBOutlet weak var resp: LineChartView!
    @IBOutlet weak var o2: LineChartView!
    
    var tempData = [98.5, 98.6, 98.8, 98.45, 98.64, 98.51, 98.43]
    var sysData = [142.0, 140.0, 137.0, 130.0, 130.0, 128.0, 124.0]
    var diasData = [95.0, 94.0, 90.0, 89.0, 88.0, 84.0, 80.0]
    var respData = [18.0, 16.0, 18.0, 19.0, 17.0, 18.0, 20.0]
    var o2Data = [97.0, 96.0, 98.0, 98.0, 96.0, 97.0, 99.0]
    
    var dates = ["4/27/18", "4/28/18", "4/29/18", "4/30/18", "5/01/18", "5/02/18", "5/03/18"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        drawTemp()
        drawResp()
        drawO2()
        drawBP()
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawTemp() {
        var lineData = [ChartDataEntry]();
        
        for i in 0..<tempData.count {
            let value = ChartDataEntry(x: Double(i), y: tempData[i]);
            lineData.append(value);
        }
        
        let line = LineChartDataSet(values: lineData, label: "Temperature");
        line.colors = [UIColor.white]
        line.lineWidth = 2
        line.drawValuesEnabled = false
        line.drawCirclesEnabled = false;
        
        let data = LineChartData();
        data.addDataSet(line);
        
        temp.data = data;
        temp.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        temp.noDataText = "Loading..."
        temp.chartDescription?.text = ""
        temp.xAxis.labelPosition = .bottom
        temp.rightAxis.drawGridLinesEnabled = false
        temp.leftAxis.drawLabelsEnabled = true
        temp.rightAxis.drawLabelsEnabled = false
        temp.leftAxis.axisMinimum = 95
        temp.leftAxis.axisMaximum = 102
        
        temp.legend.enabled = false
    }
    
    func drawResp() {
        var lineData = [ChartDataEntry]();
        
        for i in 0..<respData.count {
            let value = ChartDataEntry(x: Double(i), y: respData[i]);
            lineData.append(value);
        }
        
        let line = LineChartDataSet(values: lineData, label: "Respiration Rate");
        line.colors = [UIColor.white]
        line.lineWidth = 2
        line.drawValuesEnabled = false
        line.drawCirclesEnabled = false;
        
        let data = LineChartData();
        data.addDataSet(line);
        
        resp.data = data;
        
        resp.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        resp.noDataText = "Loading..."
        resp.chartDescription?.text = ""
        resp.xAxis.labelPosition = .bottom
        resp.rightAxis.drawGridLinesEnabled = false
        resp.leftAxis.drawLabelsEnabled = true
        resp.rightAxis.drawLabelsEnabled = false
        resp.leftAxis.axisMinimum = 15
        resp.leftAxis.axisMaximum = 20
        
        resp.legend.enabled = false
    }
    
    func drawO2() {
        var lineData = [ChartDataEntry]();
        
        for i in 0..<o2Data.count {
            let value = ChartDataEntry(x: Double(i), y: o2Data[i]);
            lineData.append(value);
        }
        
        let line = LineChartDataSet(values: lineData, label: "Oxygen Saturation");
        line.colors = [UIColor.white]
        line.lineWidth = 2
        line.drawValuesEnabled = false
        line.drawCirclesEnabled = false;
        
        let data = LineChartData();
        data.addDataSet(line);
        
        o2.data = data;
        
        o2.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        o2.noDataText = "Loading..."
        o2.chartDescription?.text = ""
        o2.xAxis.labelPosition = .bottom
        o2.rightAxis.drawGridLinesEnabled = false
        o2.leftAxis.drawLabelsEnabled = true
        o2.rightAxis.drawLabelsEnabled = false
        o2.leftAxis.axisMinimum = 95
        o2.leftAxis.axisMaximum = 100
        
        o2.legend.enabled = false
    }
    
    func drawBP() {
        var sysLineData = [ChartDataEntry]();
        
        for i in 0..<sysData.count {
            let value = ChartDataEntry(x: Double(i), y: sysData[i]);
            sysLineData.append(value);
        }
        
        let sysLine = LineChartDataSet(values: sysLineData, label: "Systolic");
        sysLine.colors = [UIColor.white]
        sysLine.lineWidth = 2
        sysLine.drawValuesEnabled = false
        sysLine.drawCirclesEnabled = false;
        
        var diasLineData = [ChartDataEntry]();
        
        for i in 0..<diasData.count {
            let value = ChartDataEntry(x: Double(i), y: diasData[i]);
            diasLineData.append(value);
        }
        
        let diasLine = LineChartDataSet(values: diasLineData, label: "Diastolic");
        diasLine.colors = [NSUIColor(red: 43.0/255.0, green: 244.0/255.0, blue: 203.0/255.0, alpha: 1.0)]
        diasLine.lineWidth = 2
        diasLine.drawValuesEnabled = false
        diasLine.drawCirclesEnabled = false;
        
        let data = LineChartData();
        data.addDataSet(sysLine);
        data.addDataSet(diasLine);
        
        bp.data = data;
        
        bp.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        bp.noDataText = "Loading..."
        bp.chartDescription?.text = ""
        bp.xAxis.labelPosition = .bottom
        bp.rightAxis.drawGridLinesEnabled = false
        bp.leftAxis.drawLabelsEnabled = true
        bp.rightAxis.drawLabelsEnabled = false
        bp.leftAxis.axisMinimum = 80
        bp.leftAxis.axisMaximum = 150
        
        bp.legend.enabled = true
    }
    
}
