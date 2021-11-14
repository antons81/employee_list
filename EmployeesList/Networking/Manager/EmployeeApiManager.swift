//
//  SetupApiManager.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.08.2021.
//

import Foundation


class EmployeeApiManager: NetworkManager {
    
    private let tallinnRouter = Router<TallinnEmployeeApi>()
    private let tartuRouter = Router<TartuEmployeeApi>()
    
    func fetchTallinEmployees(completion: @escaping (_ setup: Employees?, _ error: String?) -> Void) {
        
        tallinnRouter.request(.tallinn_employee_list) { data, response, error in
            
            if let error = error {
                guard let data = error.data(using: .utf8) else { return }
                let json = try? JSONDecoder().decode(ResponseModel.self, from: data)
                completion(nil, json?.message)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let jsonData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(Employees.self,
                                                                   from: jsonData,
                                                                   keyPath: "employees")
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func fetchTartuEmployees(completion: @escaping (_ setup: Employees?, _ error: String?) -> Void) {
        
        tartuRouter.request(.tartu_employee_list) { data, response, error in
            
            if let error = error {
                guard let data = error.data(using: .utf8) else { return }
                let json = try? JSONDecoder().decode(ResponseModel.self, from: data)
                completion(nil, json?.message)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let jsonData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(Employees.self,
                                                                   from: jsonData,
                                                                   keyPath: "employees")
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
