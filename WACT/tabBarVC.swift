//
//  tabBarVC.swift
//  WACT
//
//  Created by Clara on 3/26/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make unselected icons dark gray
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
    }
}
