//
//  SecondViewController.swift
//  WACT
//
//  Created by Clara on 3/26/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import UIKit
import Foundation
import Charts


class HeartVC: UIViewController {

    let colors = Colors()
    
    @IBOutlet weak var lineChart: LineChartView!
    
    var plotTimer : Timer!
    var piTimer : Timer!
    
    func startPlotTimer() {
        if plotTimer == nil {
            plotTimer = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(plotData), userInfo: nil, repeats: true)
        }
    }
    
    func startPiTimer() {
        if piTimer == nil {
            piTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(piRead), userInfo: nil, repeats: true)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        startPiTimer()
        startPlotTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if piTimer != nil {
            piTimer.invalidate()
            piTimer = nil
        }
        if plotTimer != nil {
            plotTimer.invalidate()
            plotTimer = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.noDataText = "Loading..."
        lineChart.chartDescription?.text = ""
        lineChart.xAxis.labelPosition = .bottom
        lineChart.drawGridBackgroundEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.drawLabelsEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        lineChart.xAxis.drawLabelsEnabled = false
        lineChart.gridBackgroundColor = NSUIColor.clear
        lineChart.drawMarkers = false
        lineChart.borderColor = UIColor.clear
        lineChart.legend.enabled = false
        
        lineChart.leftAxis.axisMinimum = 0
        lineChart.leftAxis.axisMaximum = 1000
        lineChart.xAxis.axisMinimum = 0
        lineChart.xAxis.axisMaximum = 256

        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        /*clearECGData() { done in
            print("finished clearing data")
            DispatchQueue.global(qos: .utility).async {
                /*for i in 0...256{
                    print("reading data, i is")
                    print(i)
                    self.readData() { output in
                        print("got output, i is")
                        print(i)
                        print(output)
                        
                        DispatchQueue.main.sync {
                            print("about to draw graph, i is")
                            print(i)
                           // self.drawGraph(ecgData: self.movingAverage(input: output))
                           self.drawGraph(ecgData: output)
                            
                            let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm:ss.SSSS"
                            print(formatter.string(from: date))
                        }
                    }
               }*/
               var counter = 0
               // while (counter < 5) {
                    //print("in while loop")
                    //print(counter)

                    self.piRead(count: counter) {counter in
                        print("in pi read in main")
                        DispatchQueue.global(qos: .utility).async {
                            print("in dispatch queue")
                            self.getECG() {output in
                                print("in get ecg")
                                print(output)
                                DispatchQueue.main.sync {
                                    print("about to graph")
                                    print(output)
                                    //self.drawGraph(ecgData:output)
                                    //var filtered = self.lowPass(waveform: output)
                       
                                    self.drawGraph(ecgData: output)
                                    
                                }
                            }
                        }
                    }
                //}
            }
        }*/
    }
    
    @objc func plotData(_timer : Timer) {
        print("in plot data function")
        self.getECG() { output in
            print("got ecg")
             DispatchQueue.global(qos: .utility).async {
                print("about to graph data")
                var graphData : Array<Double> = []
                for i in 0..<output.count {
                    print("in for loop, i is")
                    print(i)
                   
                    graphData.append(output[i])
                    usleep(4000)
                    print(graphData)
                    DispatchQueue.main.async{
                        self.drawGraph(ecgData: graphData)
                    }
                }
            }
        }
    }
    

    func lowPass(waveform:Array<Double>) -> Array<Double>{
        var filtered : Array<Double>  = highPass(waveform: waveform)
        for i in 0..<filtered.count {
            filtered[i] = 1 - filtered[i]
        }
        return filtered
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getECG(completion: @escaping (Array<Double>)->()){
        var output : Array<Double>  = [];
        let url2 = URL(string: "https://sheltered-spire-45551.herokuapp.com/")
        
        let task2 = URLSession.shared.dataTask(with: url2!) {(data, response, error) in
            output = try! JSONSerialization.jsonObject(with: data!, options: []) as! Array<Double>
            completion(output)
        }
        
        task2.resume()
        
    }
    
    @objc func piRead(_timer : Timer) {
        let url = URL(string: "http://192.168.1.172:3000")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            usleep(1000000)
        }
        task.resume()
    }
    
    func clearECGData(completion: @escaping (Bool)->())  {
        let url = URL(string: "https://sheltered-spire-45551.herokuapp.com/clear")
         
         let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            print("cleared the mongo database")
            completion(true)
         }
         task.resume()
    }
    

    func drawGraph(ecgData: Array<Double>) {
        var lineData = [ChartDataEntry]();
        
        for i in 0..<ecgData.count {
            let value = ChartDataEntry(x: Double(i), y: ecgData[i]);
            lineData.append(value);
        }
        
        let line = LineChartDataSet(values: lineData, label: "ECG Data");
 
        line.colors = [UIColor.white]
        line.lineWidth = 2
        line.drawValuesEnabled = false
        
        let data = LineChartData();
        data.addDataSet(line);
        
        line.drawCirclesEnabled = false;
        lineChart.data = data;
    }
    
    
    
    func highPass(waveform:Array<Double>) -> Array<Double>{
        let Fsamp : Double = 125
       
        let Fc : Double = 25;
        //let freq_cutoff : Double = Fc/Fsamp;
        let freq_cutoff : Double = 0.76;
        
        //let sLimit : Int = 25;
        let sLimit : Int = 16; // make this half the number of points being sampled
        var n: Array<Int> = Array(repeating: 0, count: 2 * sLimit  + 1)
        for i in -sLimit...sLimit {
            n[i + sLimit] = i;
        }
        
        // define the impluse response fo the filter -- for low pass
        // this is a sinc filter in the time domain
        let h: Array<Double> = theSinc(n: n, freqCutoff: freq_cutoff)
        
        // define the blackman window to truncate the impulse response
        // window length
        let N : Int  = sLimit * 2;
        for i in 0...N {
            n[i] = i;
        }
        
        var blackmanWindow : Array<Double> = Array(repeating: 0, count: n.count)
        for i in 0..<n.count {
            blackmanWindow[i] = 0.42 - 0.5 * cos(2.0 * Double.pi * Double(n[i])/Double(N-1)) + 0.08 * cos(4.0 * Double.pi * Double(n[i])/Double(N-1));
        }
        
        var hBlackman : Array<Double> = Array(repeating: 0, count: blackmanWindow.count)
        for i in 0..<hBlackman.count {
            hBlackman[i] = h[i] * blackmanWindow[i]
        }
        
        // create normalized impulse response
        var hNorm : Array<Double> = Array(repeating: 0, count: hBlackman.count)
        let sum : Double = theSum(f: hBlackman)
        for i in 0..<hNorm.count {
            hNorm[i] = hBlackman[i] / sum;
        }
        
        // ****************************************************
        // ****************************************************
        // create HIGH PASS filter from the normalized low pass filter
        // using spectral inversion
        // Step 1: change the sign of eav value of h
        var hN : Array<Double> = Array(repeating: 0, count: hNorm.count)
        for i in 0..<hN.count {
            hN[i] = -hNorm[i];
        }
        // Step 2: add 1 to the value in the center of the filter
        // subtracted 1 from center because 0 based
        let hN_length : Int = hN.count;
        let hN_center : Int = Int(round(Double(hN_length)/2.0));
        hN[hN_center - 1] = hN[hN_center - 1] + 1;
        
        // Step 3: set the high pass filter to the filter variable
        for i in 0..<hN.count {
            hNorm[i] = hN[i]
        }
        //var HN : Array<Complex> = fft(x: hNorm)
        
        let output : Array<Double> = dspConv(x: waveform, h: hNorm);
        return output;
    }
    
    func theSinc(n: Array<Int>, freqCutoff: Double) -> Array<Double> {
        var s: Array<Double> = Array(repeating: 0, count: n.count)
        var x : Double = 0
        
        for i in 0..<n.count {
            x = Double.pi * freqCutoff * Double(n[i])
            if (n[i] == 0) {
                s[i] = 1
            }
            else {
                s[i] = sin(x) / x
            }
        }
        return s;
    }
    
    func theSum(f: Array<Double>) -> Double {
        let n : Int = f.count;
        var s : Double = 0;
        for i in 0..<n {
            s = s + f[i]
        }
        return s;
    }
    
    func dspConv(x: Array<Double>, h: Array<Double>) -> Array<Double> {
        let X : Array<Double> = x + Array(repeating: 0.0, count: h.count)
        let H : Array<Double> = h + Array(repeating: 0.0, count: x.count)
        var out : Array<Double> = Array(repeating: 0.0, count: h.count + x.count - 1)
        for i in 0..<(h.count + x.count - 1) {
            for j in 0..<x.count {
                if i - j + 1 > 0 {
                    out[i] = out[i] + X[j] * H[i - j];
                }
            }
        }
        return out;
    }
    
    // use delay of 4 or 5
    func movingAverage(input: Array<Double>) -> Array<Double>{
        let delay : Double = 3;
        let zDelay : Array<Double> = Array(repeating: 0, count: Int(delay));
        let inputDelay : Array<Double> = zDelay + input + zDelay;
        
        let delayRange : Double = delay * 2 + 1;
        let inputDelayLen : Int = inputDelay.count;
        
        var outputAddition : Array<Double> = Array(repeating: 0.0, count: inputDelayLen)
        
        for i in Int(delay)..<(inputDelayLen - (Int(delay))) {
            for j in -Int(delay)...Int(delay) {
                outputAddition[i] = outputAddition[i] + inputDelay[i+j];
            }
            outputAddition[i] = outputAddition[i]/delayRange;
        }
        
        return outputAddition
    }
    
}

