//
//  EmployeeListPresenter.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVFoundation
import Contacts
import ContactsUI

protocol EmployeeListPresenterProtocol: AnyObject {
    var view: EmployeeListViewProtocol? { get set }
    func viewDidLoad()
    func fetchData()
}

class EmployeeListPresenter: NSObject {
    
    // MARK: - Public variables
    internal weak var view: EmployeeListViewProtocol?

    // MARK: - Private variables
    private let router: EmployeeListRouterProtocol
    private let service: EmployeeListServiceProtocol
    
    private let group = DispatchGroup()
    
    private var items = [Any]()
    private var tallinnEmployees = Employees()
    private var tartuEmployees = Employees()
    private var all = Employees()
    
    private var matchedContacts = [String]()
    
    // MARK: - Initialization
    init(router: EmployeeListRouterProtocol,
         view: EmployeeListViewProtocol,
         service: EmployeeListServiceProtocol) {
        
        self.service = service
        self.router = router
        self.view = view
    }
    
    func composePositions() -> [String] {
        return all.map ({ $0.position }).sorted(by: {$0 < $1}).unique()
    }
    
    private func validateContact(_ name: String) -> (CNContact?, isMatched: Bool) {
        let contacts = ContactsHelper.fetchPhoneContacts()
        let filtered = contacts.filter { $0.givenName + " " + $0.familyName == name }.first
        return (filtered, isMatched: filtered != nil)
    }
    
    private func composeCells() {
        
        items.removeAll()
        all.removeAll()
        tallinnEmployees.removeAll()
        tallinnEmployees.removeAll()
        
        all = tallinnEmployees
        all.append(contentsOf: tartuEmployees)
        
        for position in composePositions() {
            
            // insert position header
            items.append(position)
            
            // fetch employee by position
            self.all = self.all.sorted (by: { ($0.lastName, $0.firstName) < ($1.lastName, $1.firstName) }).unique()
            let employees = all.filter { $0.position == position }
            for employee in employees {
                items.append(employee)
            }
        }
        
        mainThread {
            self.view?.endRefreshControl()
            self.view?.stopSpinner()
            self.view?.reloadTable()
        }
    }
    
    func fetchData() {
    
        view?.startSpinner()
        group.enter()
        
        service.fetchTallinnList { [weak self] tallinData in
            guard let self = self else { return }
            self.tallinnEmployees = tallinData
            self.group.leave()
        }
        
        group.enter()
        service.fetchTartuList { [weak self] tartuData in
            guard let self = self else { return }
            self.tartuEmployees = tartuData
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.composeCells()
        }
    }
}

extension EmployeeListPresenter: EmployeeListPresenterProtocol {
    
    func viewDidLoad() {
        view?.setupTableView()
        fetchData()
    }
}


extension EmployeeListPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        if item is String {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PositionCell
            cell.setup(item as! String)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as EmployeeCell
            let item = item as! EmployeeModel
            let fullName = item.firstName + " " + item.lastName
            let isMatchedContact = validateContact(fullName).isMatched
            let contact = validateContact(fullName).0 ?? CNContact()
            cell.setup(item, isMatchedContact: isMatchedContact, contact: contact)
            
            cell.didTapDetailButton = { contact in
                mainThread {
                    self.router.openExistingContact(contact, delegate: self)
                }
            }
            
            return cell
        }
    }
}

extension EmployeeListPresenter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.row]
        
        if item is String {
            return 25
        } else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        if item is String {
            return
        } else {
            if let contact = item as? EmployeeModel {
                let fullName = contact.firstName + " " + contact.lastName
                let isMatchedContact = validateContact(fullName).isMatched
                let currentContact = validateContact(fullName).0 ?? CNContact()
                router.openContactDetails(contact, contactUI: currentContact, isMatched: isMatchedContact)
            }
        }
    }
}

extension EmployeeListPresenter: CNContactViewControllerDelegate {
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {}
}
