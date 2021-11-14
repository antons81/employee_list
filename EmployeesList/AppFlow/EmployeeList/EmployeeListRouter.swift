//
//  EmployeeListRouter.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

protocol EmployeeListRouterProtocol: AnyObject {
    var view: EmployeeListViewController? { get set }
    func openContactDetails(_ contact: EmployeeModel, contactUI: CNContact, isMatched: Bool)
    func openExistingContact(_ contact: CNContact, delegate: CNContactViewControllerDelegate)
}

class EmployeeListRouter {
    // MARK: - Public variables
    internal weak var view: EmployeeListViewController?
    
    // MARK: - Initialization
    init(view: EmployeeListViewController) {
        self.view = view
    }

}

extension EmployeeListRouter: EmployeeListRouterProtocol {
    
    func openExistingContact(_ contact: CNContact, delegate: CNContactViewControllerDelegate) {
        
        let contactUI = CNContactViewController(for: contact)
        contactUI.delegate = delegate
        contactUI.allowsEditing = false
        contactUI.allowsActions = false
        view?.navigationController?.pushViewController(contactUI, animated: true)
    }
    
    func openContactDetails(_ contact: EmployeeModel, contactUI: CNContact, isMatched: Bool) {
        let details = EmployeeDetailsConfigurator().makeViewController(contact,
                                                                       contactUI: contactUI,
                                                                       isMatched: isMatched)
        view?.navigationController?.pushViewController(details, animated: true)
    }
}
