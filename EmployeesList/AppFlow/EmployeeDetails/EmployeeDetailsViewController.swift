//
//  EmployeeDetailsViewController.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 14.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EmployeeDetailsViewProtocol: AnyObject {
    func updateUI(_ contact: EmployeeModel)
    func updateRightButton(_ isMatched: Bool)
}

class EmployeeDetailsViewController: UIViewController {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var position: UILabel!
    
    @IBOutlet var projectsStackView: UIStackView!
    
    // MARK: - Public properties
    var presenter: EmployeeDetailsPresenterProtocol?
    var configurator: EmployeeDetailsConfiguratorProtocol?
    
    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    @IBAction func back() {
        presenter?.back()
    }
    
    @IBAction func details() {
        presenter?.openDetails()
    }
    
    // MARK: - Overrides
    
    // MARK: - Private functions
}

extension EmployeeDetailsViewController: EmployeeDetailsViewProtocol {
    
    func updateUI(_ contact: EmployeeModel) {
        
        title = contact.firstName + " " + contact.lastName
        name.text = contact.firstName + " " + contact.lastName
        email.text = contact.contactDetails.email
        phone.text = contact.contactDetails.phone != nil ? contact.contactDetails.phone : "No phone number"
        position.text = contact.position
        
        if let projects = contact.projects {
            for project in projects {
                let projectButtonView = UIButton()
                projectButtonView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
                projectButtonView.titleLabel?.numberOfLines = 0
                projectButtonView.titleLabel?.adjustsFontSizeToFitWidth = true
                projectButtonView.titleLabel?.lineBreakMode = .byWordWrapping
                projectButtonView.backgroundColor = .lavenderBlue
                projectButtonView.layer.cornerRadius = 16
                projectButtonView.setTitle(project, for: .normal)
                projectsStackView.addArrangedSubview(projectButtonView)
            }
        }
    }
    
    func updateRightButton(_ isMatched: Bool) {
        if !isMatched {
            navigationItem.rightBarButtonItems?.removeAll()
        }
    }
}
