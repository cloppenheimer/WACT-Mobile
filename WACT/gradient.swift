//
//  gradient.swift
//  WACT
//
//  Created by Clara on 5/2/18.
//  Copyright © 2018 Clara. All rights reserved.
// Credit to https://stackoverflow.com/questions/24380535/how-to-apply-gradient-to-background-view-of-ios-swift-app?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
import Foundation
import UIKit



class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 49.0 / 255.0, green: 152.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 205.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
