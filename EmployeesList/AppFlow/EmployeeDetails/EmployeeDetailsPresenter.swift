//
//  EmployeeDetailsPresenter.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 14.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Contacts

protocol EmployeeDetailsPresenterProtocol: AnyObject {
    var view: EmployeeDetailsViewProtocol? { get set }
    func viewDidLoad()
    func back()
    func openDetails()
}

class EmployeeDetailsPresenter {
    
    
    // MARK: - Public variables
    internal weak var view: EmployeeDetailsViewProtocol?

    // MARK: - Private variables
    private let router: EmployeeDetailsRouterProtocol
    private let service: EmployeeDetailsServiceProtocol
    
    private var contact: EmployeeModel
    private var contactUI: CNContact
    private var isMatched: Bool
    
    // MARK: - Initialization
    init(router: EmployeeDetailsRouterProtocol,
         view: EmployeeDetailsViewProtocol,
         service: EmployeeDetailsServiceProtocol,
         contact: EmployeeModel,
         contactUI: CNContact,
         isMatched: Bool) {
        
        self.service = service
        self.router = router
        self.view = view
        self.contact = contact
        self.contactUI = contactUI
        self.isMatched = isMatched
    }
    
    func openDetails() {
        router.openExistingContact(contactUI)
    }
}

extension EmployeeDetailsPresenter: EmployeeDetailsPresenterProtocol {
    
    func viewDidLoad() {
        view?.updateUI(contact)
        view?.updateRightButton(isMatched)
    }
    
    func back() {
        router.back()
    }
}
