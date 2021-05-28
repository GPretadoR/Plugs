//
//  LeftMenuViewController.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import ReactiveSwift

class LeftMenuViewController: BaseViewController {

    private lazy var leftMenuTableView = UITableView {
        $0.registerReusableCell(GenericTableViewCell<CommonTableViewCell>.self)
        $0.tableFooterView = UIView()
        $0.isScrollEnabled = false
    }

    private lazy var headerView = LeftMenuHeaderView()

    var viewModel: LeftMenuViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
        leftMenuTableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppearTriggered()
    }

    override func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(leftMenuTableView)
        view.addSubview(headerView)

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safe.top).offset(43)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(78)
        }
        
        leftMenuTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safe.bottom).offset(-20)
        }

    }
    
    // MARK: - Actions -

    // MARK: - Helpers -
    
    override func shouldHaveBottomLogo() -> Bool {
        true
    }
    
    override func shouldHideNavigationBar() -> Bool {
        true
    }
}

extension LeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.menuItems.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GenericTableViewCell<CommonTableViewCell>.self, for: indexPath)

        if let menuItems = viewModel?.menuItems.value {
            let menuItem = menuItems[indexPath.row]
            cell.view.configure(icon: menuItem.icon, titleText: menuItem.titleText)
        }

        cell.selectionStyle = .none

        return cell
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(at: indexPath)
    }
}
