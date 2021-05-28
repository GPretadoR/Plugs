//
//  FAQViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class FAQViewController: BaseViewController {
    
    var viewModel: FAQViewViewModel?
    
    private lazy var headerView = CommonHeaderView()
    
    private var faqData: [TableViewData] = []
    
    private lazy var faqTableView = UITableView {
        $0.registerReusableCell(GenericTableViewCell<CommonTableViewCell>.self)
        $0.tableFooterView = UIView()
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton(on: self, action: #selector(closeButtonTapped(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    
    override func setupViewModel() {
        super.setupViewModel()
        guard let viewModel = viewModel else { return }
        
        reactive.makeBindingTarget { (localSelf, data) in
            localSelf.faqData = data
            localSelf.faqTableView.reloadData()
        } <~ viewModel.faqDataModel
    }
    
    override func shouldHaveBottomLogo() -> Bool {
        true
    }
    
    // MARK: - Actions
    
    @objc func closeButtonTapped(_ sender: Any) {
        viewModel?.didTapCloseButton()
    }
}

extension FAQViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        faqData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = faqData[section]
        if sectionData.isExpanded {
            return sectionData.data.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(GenericTableViewCell<CommonTableViewCell>.self, for: indexPath)
        cell.view.accessoryView = nil
        if indexPath.row == 0 {
            let sectionData = faqData[indexPath.section]
            cell.view.configure(titleText: sectionData.title)
            cell.view.accessoryView = makeArrowImage(isExpanded: sectionData.isExpanded)
        } else {
            cell.view.configure(titleText: faqData[indexPath.section].data[indexPath.row - 1])
            cell.view.makeResizable()
        }
        cell.view.backgroundColor = .white
        return cell
    }
    
    private func makeArrowImage(isExpanded: Bool) -> UIView {
        let imageView = UIImageView(image: R.image.expandArrow())
        if isExpanded {
            let rotatedImageView = imageView.transform.rotated(by: .pi)
            imageView.transform = rotatedImageView
        }
        return imageView
    }
}

extension FAQViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
            faqData[indexPath.section].isExpanded = !faqData[indexPath.section].isExpanded
            tableView.reloadSections([indexPath.section], with: .none)
        }
    }
}
