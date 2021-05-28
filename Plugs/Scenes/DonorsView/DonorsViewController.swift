//
//  DonorsViewController.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 15.04.21.
//  Copyright © 2021 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class DonorsViewController: BaseViewController {

    var viewModel: DonorsViewViewModel?
    
    private lazy var headerView = CommonHeaderView()
    
    private lazy var desctiptionLabel = AppLabel {
        $0.style(textStyle: .regular16px, color: R.color.grayTextColor()!)
        $0.text = R.string.localizable.aboutUsViewDescriptionText.localized()
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
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

        prepareImageCollection()
        
        headerView.configureTitle(text: R.string.localizable.donorsTitleText.localized())
    }

    override func shouldHaveBottomLogo() -> Bool {
        true
    }
    
    // MARK: - Private
    
    private func prepareImageCollection() {
        
        let topImageCollection: [UIImage] = [R.image.gef()!, R.image.sgp()!]
        let bottomImageCollection: [UIImage] = [R.image.aea()!, R.image.undp()!]
        
        let topHStackView = UIStackView {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 50
        }
        
        let bottomHStackView = UIStackView {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 50
        }
        
        let imagesVStackView = UIStackView {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }
        
        topImageCollection.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            topHStackView.addArrangedSubview(imageView)
        }
        
        bottomImageCollection.forEach { image in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            bottomHStackView.addArrangedSubview(imageView)
        }
        
        imagesVStackView.addArrangedSubview(topHStackView)
        imagesVStackView.addArrangedSubview(bottomHStackView)
        view.addSubview(imagesVStackView)
        
        imagesVStackView.snp.makeConstraints { make in
            make.top.equalTo(desctiptionLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - Actions

    @objc func closeButtonTapped(_ sender: Any) {
        viewModel?.didTapCloseButton()
    }
}
