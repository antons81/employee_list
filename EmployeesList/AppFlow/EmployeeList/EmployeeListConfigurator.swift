//
//  EmployeeListConfigurator.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EmployeeListConfiguratorProtocol: AnyObject {
    func makeViewController() -> EmployeeListViewController
    func config(viewController: EmployeeListViewController)
}

class EmployeeListConfigurator {
}

extension EmployeeListConfigurator: EmployeeListConfiguratorProtocol {
    
    func makeViewController() -> EmployeeListViewController {

        guard let viewController = EmployeeListViewController.instatiateFromNib(.main) as? EmployeeListViewController else {
            fatalErrorOnInit(with: EmployeeListViewController.vcName)
        }
        
        viewController.configurator = self
        return viewController
    }

    func config(viewController: EmployeeListViewController) {
        let service = EmployeeListService()
        let router = EmployeeListRouter(view: viewController)
        let presenter = EmployeeListPresenter(router: router,
        view: viewController,
        service: service)
        viewController.presenter = presenter
    }

}
