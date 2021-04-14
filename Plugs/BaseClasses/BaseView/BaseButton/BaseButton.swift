//
//  BaseButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/6/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

enum VelviooButtonStyle {
    case fill
    case border
    case fillAndIcon
    case borderAndIcon
}

class BaseButton: UIButton {

    var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
        }
    }

    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    var textColor: UIColor = .blue {
        didSet {
            setTitleColor(textColor, for: .normal)
        }
    }

    var highlightedTextColor: UIColor = .lightGray {
        didSet {
            setTitleColor(highlightedTextColor, for: .highlighted)
        }
    }

    var icon: UIImage? {
        didSet {
            setImage(icon, for: .normal)
        }
    }

    var backgroundImage: UIImage? {
        didSet {
            setBackgroundImage(backgroundImage, for: .normal)
        }
    }

    var highLightedIcon: UIImage? {
        didSet {
            setImage(highLightedIcon, for: .highlighted)
        }
    }

    var hasShadow: Bool = false {
        didSet {
            if self.hasShadow {
                self.addCornerRadiusAndShadow(cornerRadius: layer.cornerRadius,
                                              shadowColor: .black,
                                              shadowOffset: CGSize(width: 0.0, height: 6.0),
                                              shadowRadius: layer.cornerRadius,
                                              shadowOpacity: 0.25)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        layer.cornerRadius = 6
        highlightedTextColor = .systemGray
    }

    private func setBackgroundColor(color: UIColor?, for state: UIControl.State) {
        guard let color = color else { return }
        setBackgroundImage(UIImage(ciImage: CIImage(color: CIColor(cgColor: color.cgColor))), for: state)
    }
}
