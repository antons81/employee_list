//
//  EmployeeDetailsConfigurator.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 14.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Contacts

protocol EmployeeDetailsConfiguratorProtocol: AnyObject {
    func makeViewController(_ contact: EmployeeModel,
                            contactUI: CNContact,
                            isMatched: Bool) -> EmployeeDetailsViewController
    
    func config(viewController: EmployeeDetailsViewController)
}

class EmployeeDetailsConfigurator {
    private var contact: EmployeeModel!
    private var contactUI: CNContact!
    private var isMatched: Bool!
}

extension EmployeeDetailsConfigurator: EmployeeDetailsConfiguratorProtocol {
    
    func makeViewController(_ contact: EmployeeModel,
                            contactUI: CNContact,
                            isMatched: Bool) -> EmployeeDetailsViewController {
        
        guard let viewController = EmployeeDetailsViewController.instatiateFromNib(.main) as? EmployeeDetailsViewController else {
            fatalErrorOnInit(with: EmployeeDetailsViewController.vcName)
        }
        
        self.contact = contact
        self.contactUI = contactUI
        self.isMatched = isMatched
        
        viewController.configurator = self
        return viewController
    }
    
    func config(viewController: EmployeeDetailsViewController) {
        let service = EmployeeDetailsService()
        let router = EmployeeDetailsRouter(view: viewController)
        let presenter = EmployeeDetailsPresenter(router: router,
                                                 view: viewController,
                                                 service: service,
                                                 contact: self.contact,
                                                 contactUI: self.contactUI,
                                                 isMatched: self.isMatched)
        viewController.presenter = presenter
    }
}
