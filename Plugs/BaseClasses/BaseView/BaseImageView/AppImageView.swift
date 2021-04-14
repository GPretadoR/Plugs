//
//  AppImageView.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 4/8/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class AppImageView: BaseImageView {

    var imageRenderingMode: UIImage.RenderingMode = .alwaysTemplate

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDefaultValues()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// Image with ability to change colors. Use 'image' property for original icon color
    var tintableImage: UIImage? {
        get {
            image
        }
        set {
            let tintableImage = newValue?.withRenderingMode(imageRenderingMode)
            image = tintableImage
        }
    }

    private func configureDefaultValues() {
        tintColor = .systemBlue
    }
}
