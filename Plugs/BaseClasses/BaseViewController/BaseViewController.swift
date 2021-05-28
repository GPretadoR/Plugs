//
//  BaseViewController.swift
//  RakutenShop
//
//  Created by Garnik Ghazaryan on 2/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {

    private lazy var footerImageView = UIImageView {
        $0.image = #imageLiteral(resourceName: "PlugLogoGrey")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarStyle()
        
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setContainerView(self.view)
        
        SVProgressHUD.setMaximumDismissTimeInterval(2.0)
//        SVProgressHUD.setBackgroundColor(AppColors.appMainThemeColor)
//        SVProgressHUD.setForegroundColor(AppColors.white)
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupViewModel()
        setupReactiveComponents()
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = shouldHideNavigationBar()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = !shouldHideNavigationBar()
    }
    
    func setupView() {
        setupTexts()
        
        if shouldHaveBottomLogo() {
            view.addSubview(footerImageView)
            
            footerImageView.snp.makeConstraints { make in
                make.bottom.equalTo(view.safe.bottom).offset(-34)
                make.centerX.equalToSuperview()
            }
        }
    }

    func setupViewModel() {}
    
    func setupTexts() {}
    
    func setupReactiveComponents() {}
    
    func shouldHideNavigationBar() -> Bool { false }
    
    func shouldHaveBottomLogo() -> Bool { false }
    
    func addCloseButton(on vc: UIViewController, action: Selector) {
        guard let closeImage = R.image.ic_close() else { return }
        closeImage.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: closeImage.size.width - 1, bottom: 0, right: 0))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: action)
    }
    
    // MARK: - Private func
    
    private func navigationBarStyle() {
        guard let navigationController = navigationController else { return }
        guard let backButtonBackgroundImage = R.image.ic_back() else { return }
        backButtonBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: backButtonBackgroundImage.size.width - 1, bottom: 0, right: 0))
        
        navigationController.navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        navigationController.navigationBar.tintColor = .white
        
        navigationController.navigationBar.barTintColor = R.color.darkCyan()
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationItem.backBarButtonItem?.setTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 12.0), for: UIBarMetrics.default)
    }
}
