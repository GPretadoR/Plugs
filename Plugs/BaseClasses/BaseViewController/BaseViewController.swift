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

    func setupView() {
        setupTexts()
    }

    func setupViewModel() {}
    
    func setupTexts() {}
    
    func setupReactiveComponents() {}
    
    private func navigationBarStyle() {
        guard let navigationController = navigationController else { return }
        guard let backButtonBackgroundImage = R.image.ic_back() else { return }    
        backButtonBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: backButtonBackgroundImage.size.width - 1, bottom: 0, right: 0))

        navigationController.navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        navigationController.navigationBar.tintColor = .black
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        navigationItem.backBarButtonItem?.setTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 12.0), for: UIBarMetrics.default)
    }
}
