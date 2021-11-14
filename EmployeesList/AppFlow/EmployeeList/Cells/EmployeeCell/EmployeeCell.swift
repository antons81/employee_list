//
//  EmployeeCell.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import UIKit
import Contacts

class EmployeeCell: UITableViewCell, NibReusable {
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var detailsButton: UIButton!
    
    private var contact: CNContact!
    var isMatched = false
    
    var didTapDetailButton: ((CNContact) -> Void)?
    
    @IBAction func didTapOnDetails() {
        guard let contact = self.contact else { return }
        didTapDetailButton?(contact)
    }
    
    func setup(_ user: EmployeeModel, isMatchedContact: Bool, contact: CNContact) {
        firstName.text = user.firstName
        lastName.text = user.lastName
        detailsButton.isHidden = !isMatchedContact
        self.contact = contact
        self.isMatched = isMatchedContact
    }
}
