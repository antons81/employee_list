//
//  ProjectCell.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import UIKit

class PositionCell: UITableViewCell, NibReusable {
    
    @IBOutlet var position: UILabel!
    
    func setup( _ name: String) {
        position.text = name
    }
}
