//
//  docVitalsVC.swift
//  WACT
//
//  Created by Clara on 5/3/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket
import Foundation

class DocVitalsVC: UIViewController {
    
    
    @IBOutlet weak var fahrenheit: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var bloodpressure: UILabel!
    @IBOutlet weak var resp_rate: UILabel!
    @IBOutlet weak var oxygen_sat: UILabel!
    
    let colors = Colors()
    
    var tempTimer : Timer!
    
    func startTimer() {
        if tempTimer == nil {
            tempTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTemp), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        // Do any additional setup after loading the view, typically from a nib.
        temperature.layer.masksToBounds = true
        temperature.layer.cornerRadius = temperature.frame.width/2
        temperature.backgroundColor = .clear
        temperature.layer.borderWidth = 7
        temperature.layer.borderColor = UIColor.white.cgColor
        
        bloodpressure.layer.masksToBounds = true
        bloodpressure.layer.cornerRadius = bloodpressure.frame.width/2
        bloodpressure.backgroundColor = .clear
        bloodpressure.layer.borderWidth = 7
        bloodpressure.layer.borderColor = UIColor.white.cgColor
        
        resp_rate.layer.masksToBounds = true
        resp_rate.layer.cornerRadius = resp_rate.frame.width/2
        resp_rate.backgroundColor = .clear
        resp_rate.layer.borderWidth = 7
        resp_rate.layer.borderColor = UIColor.white.cgColor
        
        oxygen_sat.layer.masksToBounds = true
        oxygen_sat.layer.cornerRadius = oxygen_sat.frame.width/2
        oxygen_sat.backgroundColor = .clear
        oxygen_sat.layer.borderWidth = 7
        oxygen_sat.layer.borderColor = UIColor.white.cgColor
        
        
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("view did disappear")
        if tempTimer != nil {
            tempTimer.invalidate()
            tempTimer = nil
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("view will disappear")
        if tempTimer != nil {
            tempTimer.invalidate()
            tempTimer = nil
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateTemp(_timer: Timer) {
        DispatchQueue.global(qos: .utility).async {
            print("in dispatch queue")
            self.getTemp() {output in
                print("in get ecg")
                print(output)
                DispatchQueue.main.async {
                    print(output)
                    
                    if (output < 97.8 && output > 96.5) || (output > 99.1 && output < 100.8) {
                        self.temperature.textColor = UIColor.orange
                        self.fahrenheit.textColor = UIColor.orange
                        self.temperature.layer.borderColor = UIColor.orange.cgColor
                    }
                    else if (output <= 96.5 || output >= 100.8) {
                        self.temperature.textColor = UIColor.red
                        self.fahrenheit.textColor = UIColor.red
                        self.temperature.layer.borderColor = UIColor.red.cgColor
                    }
                    else {
                        self.temperature.textColor = UIColor.white
                        self.fahrenheit.textColor = UIColor.white
                        self.temperature.layer.borderColor = UIColor.white.cgColor
                    }
                    self.temperature.text = String(Double(round(100*output)/100))
                    
                }
            }
        }
    }
    

    func getTemp(completion: @escaping (Double)->()){
        var output : Array<Double> = []
        let url = URL(string: "https://sheltered-spire-45551.herokuapp.com/getTemp")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            output = try! JSONSerialization.jsonObject(with: data!, options: []) as! Array<Double>
            completion(output[0])
        }
        
        task.resume()
        
        
    }
    
    
}
