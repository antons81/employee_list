//
//  EmployeeListService.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EmployeeListServiceProtocol: AnyObject {
    func fetchTallinnList(completion: ((Employees) -> Void)?)
    func fetchTartuList(completion: ((Employees) -> Void)?)
}

class EmployeeListService {
    lazy var apiManager = EmployeeApiManager()
}

extension EmployeeListService: EmployeeListServiceProtocol {
    
    
    func fetchTallinnList(completion: ((Employees) -> Void)?) {
        
        apiManager.fetchTallinEmployees() { result, error in
            
            if error != nil {
                return
            }
            
            if let result = result {
                completion?(result)
            }
        }
    }
    
    func fetchTartuList(completion: ((Employees) -> Void)?) {
        
        apiManager.fetchTartuEmployees() { result, error in
            
            if error != nil {
                return
            }
            
            if let result = result {
                completion?(result)
            }
        }
    }
}
