//
//  AboutUsViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    var viewModel: AboutUsViewViewModel?
    
    private lazy var headerView = CommonHeaderView()
    
    private lazy var desctiptionLabel = AppLabel {
        $0.style(textStyle: .regular16px, color: R.color.grayTextColor()!)
        $0.text = R.string.localizable.aboutUsViewDescriptionText.localized()
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private lazy var projectLogoImageView = AppImageView {
        $0.image = #imageLiteral(resourceName: "Partners")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        addCloseButton(on: self, action: #selector(closeButtonTapped(_:)))
    }
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(headerView)
        view.addSubview(desctiptionLabel)
        view.addSubview(projectLogoImageView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        desctiptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(43)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        projectLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(desctiptionLabel.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
        }
        
        prepareImageCollection()
        
        headerView.configureTitle(text: R.string.localizable.aboutUsViewTitleText.localized())
    }

    override func shouldHaveBottomLogo() -> Bool {
        true
    }
    
    // MARK: - Private
    
    private func prepareImageCollection() {
        
        let topImageCollection: [UIImage] = [R.image.mask3()!, R.image.mask6()!, R.image.mask1()!]
        let bottomImageCollection: [UIImage] = [R.image.mask2()!, R.image.mask4()!, R.image.mask5()!]
        
        let topHStackView = UIStackView {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        let bottomHStackView = UIStackView {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        let imagesVStackView = UIStackView {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        topImageCollection.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.snp.makeConstraints { make in
                make.height.width.equalTo(108)
            }
            topHStackView.addArrangedSubview(imageView)
        }
        
        bottomImageCollection.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.snp.makeConstraints { make in
                make.height.width.equalTo(108)
            }
            bottomHStackView.addArrangedSubview(imageView)
        }
        
        imagesVStackView.addArrangedSubview(topHStackView)
        imagesVStackView.addArrangedSubview(bottomHStackView)
        view.addSubview(imagesVStackView)
        
        imagesVStackView.snp.makeConstraints { make in
            make.top.equalTo(projectLogoImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc func closeButtonTapped(_ sender: Any) {
        viewModel?.didTapCloseButton()
    }
}
