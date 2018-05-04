//
//  medInfoTable.swift
//  WACT
//
//  Created by Clara on 5/2/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import Foundation
import UIKit

class MedInfoTable: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clear
    }
    
    // MARK: - Table view data source
    var fields = ["Provider", "ID Number", "Group Number", "Phone Number",
                  "Provider", "ID Number", "Group Number", "Phone Number",
                  "Name", "Phone Number",
                  "Recent cardiac arrest", "Asthma", "Allergic to Penicillin",
                  "Amiodarone", "Montelukast", "Atorvastatin"]
    var details = ["Blue Cross Blue Shield", "XYZ123456789", "112397", "111-246-8902",
                   "CVS", "532413483", "32893129", "409-1299-3057",
                   "Dr. Seuss", "895-242-6544",
                   "",  "", "",
                   "400 mg/day", "10 mg/day", "20 mg/day"]
    var sections = ["Insurance Information", "Prescription Information", "Clinician", "Medical Conditions", "Medications"]
    var numRows : [Int] = [4, 4, 2, 3, 3]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("num sections")
        return 5
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < numRows.count {
            rows = numRows[section]
        }
        
        return rows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
            
            var sum = 0
            for i in 0..<indexPath.section {
                sum += numRows[i]
            }
            
            
            cell.textLabel?.text = fields[indexPath.row + sum]
            cell.detailTextLabel?.text = details[indexPath.row + sum]
            
            return cell
    }
}
