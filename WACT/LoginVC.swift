//
//  LoginVC.swift
//  WACT
//
//  Created by Clara on 3/26/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let colors = Colors()
    
    @IBOutlet weak var clinicianButton: UIButton!
    @IBOutlet weak var patientButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        clinicianButton.layer.masksToBounds = true
        clinicianButton.layer.cornerRadius = 12
        clinicianButton.backgroundColor = .clear
        clinicianButton.layer.borderWidth = 7
        clinicianButton.layer.borderColor = UIColor.white.cgColor
        
        patientButton.layer.masksToBounds = true
        patientButton.layer.cornerRadius = 12
        patientButton.backgroundColor = .clear
        patientButton.layer.borderWidth = 7
        patientButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
