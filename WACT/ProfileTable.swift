//
//  ProfileTable.swift
//  WACT
//
//  Created by Clara on 5/2/18.
//  Copyright © 2018 Clara. All rights reserved.
//

import Foundation
import UIKit

class ProfileTable: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.clear
    }
    
    // MARK: - Table view data source
    var fields = ["Gender", "Date of Birth", "Height", "Weight",
                  "Email", "Cell Phone", "Work Phone", "Home Phone", "Home Address", "Name", "Cell Phone", "Work Phone", "Home Phone"]
    var details = ["Male", "05/04/1992", "6'3''","205 lbs", "ron@gmail.com", "555-123-7408", "918-435-0021", "781-634-5371", "161 College Ave, Medford, MA 02155", "Ming Chow", "456-777-9000", "581-294-0523", "621-527-4968"]
    var sections = ["Personal Information", "Contact Information", "Emergency Contact"]
    var numRows : [Int] = [4, 5, 4]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("num sections")
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < numRows.count {
            rows = numRows[section]
        }
        
        return rows
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
            
        if indexPath.section == 2 {
            cell.textLabel?.text = fields[indexPath.row + 9]
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = fields[indexPath.row + 4]
        }
        else {
            cell.textLabel?.text = fields[indexPath.row]
        }

        if indexPath.section == 2 {
             cell.detailTextLabel?.text = details[indexPath.row + 9]
        }
        else if indexPath.section == 1 {
             cell.detailTextLabel?.text = details[indexPath.row + 4]
        }
        else {
             cell.detailTextLabel?.text = details[indexPath.row]
        }
            
        return cell
            
    }
    
    
    
}
