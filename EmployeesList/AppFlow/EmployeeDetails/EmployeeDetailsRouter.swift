//
//  EmployeeDetailsRouter.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 14.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ContactsUI

protocol EmployeeDetailsRouterProtocol: AnyObject {
    var view: EmployeeDetailsViewController? { get set }
    func back()
    func openExistingContact(_ contact: CNContact)
}

class EmployeeDetailsRouter {
    // MARK: - Public variables
    internal weak var view: EmployeeDetailsViewController?
    
    // MARK: - Initialization
    init(view: EmployeeDetailsViewController) {
        self.view = view
    }
}

extension EmployeeDetailsRouter: EmployeeDetailsRouterProtocol {
    
    func back() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func openExistingContact(_ contact: CNContact) {
        let contactUI = CNContactViewController(for: contact)
        contactUI.allowsEditing = false
        contactUI.allowsActions = false
        view?.navigationController?.pushViewController(contactUI, animated: true)
    }
}
