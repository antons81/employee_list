//
//  EmployeeListViewController.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EmployeeListViewProtocol: AnyObject {
    func setupTableView()
    func reloadTable()
    func endRefreshControl()
    func startSpinner()
    func stopSpinner()
}

class EmployeeListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    let refreshControl = UIRefreshControl()
    
    
    // MARK: - Public properties
    var presenter: EmployeeListPresenterProtocol?
    var configurator: EmployeeListConfiguratorProtocol?
    
    // MARK: - Private properties
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator?.config(viewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Display logic
    
    // MARK: - Actions
    
    // MARK: - Overrides
    
    // MARK: - Private functions
    @objc private func refresh() {
        presenter?.fetchData()
    }
}

extension EmployeeListViewController: EmployeeListViewProtocol {
    
    func setupTableView() {
        tableView.dataSource = presenter as? UITableViewDataSource
        tableView.delegate = presenter as? UITableViewDelegate
        tableView.registerCellNib(EmployeeCell.self)
        tableView.registerCellNib(PositionCell.self)
        tableView.tableFooterView = UIView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func reloadTable() {
        mainThread {
            self.tableView.reloadData()
        }
    }
    
    func endRefreshControl() {
        mainThread {
            self.refreshControl.endRefreshing()
            
        }
    }
    
    func startSpinner() {
        mainThread {
            self.spinner.startAnimating()
        }
    }
    
    func stopSpinner() {
        mainThread {
            self.spinner.stopAnimating()
        }
    }
}
