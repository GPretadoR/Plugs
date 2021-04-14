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

    var viewModel: LeftMenuViewViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        leftMenuTableView.dataSource = self
        leftMenuTableView.delegate = self
//        leftMenuTableView.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewWillAppearTriggered()
    }

    override func setupView() {
        view.backgroundColor = .lightGray
        
        view.addSubview(leftMenuTableView)

        leftMenuTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    override func setupViewModel() {
        guard let viewModel = viewModel else { return }

    }

    // MARK: - Actions -

    // MARK: - Helpers -
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
