//
//  LeftMenuViewController.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class LeftMenuViewController: BaseViewController {

    private lazy var leftMenuTableView = UITableView {
        $0.registerReusableCell(GenericTableViewCell<CommonTableViewCell>.self)        
        $0.isScrollEnabled = false
    }

    private lazy var headerView = LeftMenuHeaderView()
    
    private var toggleView = LanguageToggleView {
        $0.configure(leftTitle: "Հայ", rightTitle: "Eng")
    }

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
        super.setupView()
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
    
    override func setupViewModel() {
        super.setupViewModel()
        guard let viewModel = viewModel else { return }
        
        toggleView.toggleDidChangeValue = { isOn in
            viewModel.didSwitchToggle(isOn: isOn)
        }
        
        viewModel.toggleState
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] isOn in
                self?.toggleView.setToggleState(isOn: isOn)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.addSubview(toggleView)
        
        toggleView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.bottom.equalToSuperview()
            make.leading.equalTo(20)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.menuItems.value.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GenericTableViewCell<CommonTableViewCell>.self, for: indexPath)

        if let menuItems = viewModel?.menuItems.value {
            let menuItem = menuItems[indexPath.row]
            cell.view.configure(icon: menuItem.icon, titleText: menuItem.titleText.uppercased())
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
