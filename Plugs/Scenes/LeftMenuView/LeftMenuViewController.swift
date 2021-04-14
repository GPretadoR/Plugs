//
//  LeftMenuViewController.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/1/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift

class LeftMenuViewController: BaseViewController {

    private lazy var headerContainerView = UIView {
        $0.backgroundColor = AppColors.appBackgroundLightGrayColor
    }

    private lazy var profilePictureView = ProfilePictureView {
        $0.hasShadow = false
    }

    private lazy var profileNameLabel = AppLabel {
        $0.style(textStyle: .bold20px, color: AppColors.appDarkGrayColor)
        $0.text = R.string.localizable.leftMenuGreetingLabelText("")
    }

    private lazy var leftMenuTableView = UITableView {
        $0.registerReusableCell(GenericTableViewCell<CommonTableViewCell>.self)
        $0.tableFooterView = UIView()
        $0.isScrollEnabled = false
    }

    private lazy var profileButton = AppButton {
        $0.backgroundColor = AppColors.clear
        $0.titleText = ""
        $0.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
    }

    private lazy var statisticsView = StatisticsView {
        $0.hasShadow = true
    }

    private lazy var partneringLabel = AppLabel {
        $0.style(textStyle: .bold14px, color: AppColors.appMainThemeColor)
        $0.text = R.string.localizable.leftMenuPartneringLabelText.localized()
    }

    private lazy var sponsorLogo2ImageView = AppImageView {
        $0.backgroundColor = AppColors.clear
    }

    private lazy var partnersVStackView = UIStackView {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 3
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
        view.backgroundColor = AppColors.appBackgroundLightGrayColor

        view.addSubview(headerContainerView)
        view.addSubview(leftMenuTableView)

        headerContainerView.addSubview(profilePictureView)
        headerContainerView.addSubview(profileNameLabel)
        headerContainerView.addSubview(statisticsView)
        headerContainerView.addSubview(profileButton)

        headerContainerView.snp.makeConstraints { make in
            make.height.equalTo(175)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safe.top)
        }

        profilePictureView.snp.makeConstraints { make in
            make.height.width.equalTo(54)
            make.top.equalToSuperview().inset(27)
            make.leading.equalToSuperview().inset(24)
        }

        statisticsView.snp.makeConstraints { make in
            make.height.equalTo(68)
            make.leading.equalTo(14)
            make.trailing.equalTo(-14)
            make.top.equalTo(profilePictureView.snp.bottom).inset(-14)
        }

        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profilePictureView.snp.trailing).offset(22)
            make.centerY.equalTo(profilePictureView)
        }

        profileButton.snp.makeConstraints { make in
            make.top.equalTo(profilePictureView.snp.top)
            make.leading.equalTo(profilePictureView)
            make.trailing.equalTo(profileNameLabel.snp.trailing)
            make.height.equalTo(profilePictureView.snp.height)
        }

        leftMenuTableView.snp.makeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safe.bottom)
        }

        headerContainerView.layoutIfNeeded()
        profilePictureView.makeCircle()
    }

    override func setupViewModel() {
        guard let viewModel = viewModel else { return }

        reactive.makeBindingTarget { (localSelf, _) in
            localSelf.leftMenuTableView.reloadData()
            } <~ viewModel.menuItems
                .signal
                .skip(while: { $0.count == 0 })

        viewModel.profileName.signal
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] (firstName) in
                self?.profileNameLabel.text = R.string.localizable.leftMenuGreetingLabelText(firstName ?? "", preferredLanguages: [R.defaultLanguage.rawValue])
        }

        viewModel.avatarImage.signal
            .observe(on: UIScheduler())
            .take(duringLifetimeOf: self)
            .observeValues { [weak self] image in
                self?.profilePictureView.profilePicture = image
        }

        viewModel.sponsorLogo2
            .signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] image in
                self?.updateLogo(image: image)
            }
    }

    // MARK: - Actions -

    @objc func profileButtonTapped(_ sender: Any) {
        viewModel?.didTapProfileButton()
    }

    // MARK: - Helpers -

    private func updateLogo(image: UIImage?) {
        if let image = image {
            self.sponsorLogo2ImageView.image = image

            view.addSubview(partnersVStackView)

            partnersVStackView.addArrangedSubview(partneringLabel)
            partnersVStackView.addArrangedSubview(sponsorLogo2ImageView)

            partnersVStackView.snp.makeConstraints { make in
                make.bottom.equalTo(view.safe.bottom).offset(-40)
                make.leading.equalTo(20)
                make.trailing.equalTo(-20)
            }

            sponsorLogo2ImageView.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
        }
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
