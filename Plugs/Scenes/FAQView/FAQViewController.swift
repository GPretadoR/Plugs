//
//  FAQViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class FAQViewController: BaseViewController {
    
    var viewModel: FAQViewViewModel?
    
    private lazy var headerView = CommonHeaderView()
    
    private lazy var faqTableView = UITableView {
        $0.registerReusableCell(GenericTableViewCell<CommonTableViewCell>.self)
        $0.tableFooterView = UIView()
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton(on: self, action: #selector(closeButtonTapped(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableViewDataArray = baseData
        faqTableView.dataSource = self
        faqTableView.delegate = self
    }
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(headerView)
        view.addSubview(faqTableView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        faqTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safe.bottom).offset(-20)
        }
        
        headerView.configureTitle(text: R.string.localizable.faqTitleText.localized())
    }
    
    override func shouldHaveBottomLogo() -> Bool {
        true
    }
    
    // MARK: - Actions
    
    @objc func closeButtonTapped(_ sender: Any) {
        viewModel?.didTapCloseButton()
    }
    
    var baseData = [TableViewData(title: "a", data: [TableViewData(title: "a1", data: [TableViewData(title: "a11", data: [])])], isRoot: true),
                    TableViewData(title: "b", data: [TableViewData(title: "b1", data: [TableViewData(title: "b11", data: [TableViewData(title: "b111", data: [])]),
                                                                                       TableViewData(title: "b22", data: [])])], isRoot: true)]
    var tableViewDataArray: [TableViewData] = []
}

class TableViewData {
    let title: String
    var isExpanded: Bool = false
    var data: [TableViewData]
    var isRoot: Bool = false
    
    init(title: String, data: [TableViewData]) {
        self.title = title
        self.data = data
    }
    
    init(title: String, data: [TableViewData], isRoot: Bool) {
        self.title = title
        self.data = data
        self.isRoot = isRoot
    }
    
    func collapse() {
        for item in data {
            item.collapse()
        }
    }
}

extension FAQViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GenericTableViewCell<CommonTableViewCell>.self, for: indexPath)
        
        let menuItem = tableViewDataArray[indexPath.row]
        cell.view.configure(icon: nil, titleText: menuItem.title)
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension FAQViewController: UITableViewDelegate {
    
    func updateDataSource() {
        tableViewDataArray = tableViewDataArray.filter { $0.isExpanded || $0.isRoot }
        if tableViewDataArray.isEmpty {
            tableViewDataArray = baseData
        }
        faqTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = tableViewDataArray[indexPath.row]
        if menuItem.isExpanded {
            menuItem.collapse()
            updateDataSource()
        } else {
            menuItem.isExpanded = true
            
            let items = menuItem.data
            var insertingIndex = indexPath.row + 1
            for i in 0..<items.count {
                tableViewDataArray.insert(items[i], at: insertingIndex)
                insertingIndex += 1
            }
            tableView.reloadData()
        }
    }
}
