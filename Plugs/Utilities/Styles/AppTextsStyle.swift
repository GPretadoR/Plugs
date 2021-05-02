//
//  AppStyles.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/13/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

struct TextAttributes {
    var font: UIFont
    var textColor: UIColor?
}

enum TextsStyles: Int {
    case none

    // Bold
    case bold10px = 10
    case bold11px = 11
    case bold12px = 12
    case bold13px = 13
    case bold14px = 14
    case bold15px = 15
    case bold16px = 16
    case bold18px = 18
    case bold20px = 20
    case bold24px = 24
    case bold30px = 30
    case bold36px = 36
    case bold40px = 40

    // Medium
    case medium40px = 540

    // Regular
    case regular9px = 1009
    case regular11px = 1011
    case regular12px = 1012
    case regular13px = 1013
    case regular14px = 1014
    case regular15px = 1015
    case regular16px = 1016
    case regular18px = 1018
    case regular20px = 1020

    private var defaultFont: UIFont {
        UIFont.systemFont(ofSize: 17)
    }
    
    private var mediumSizeDelta: Int {
        500
    }
    
    private var regularSizeDelta: Int {
        1000
    }

    var style: TextAttributes {
        return style(for: self)
    }

    private func style(for style: TextsStyles) -> TextAttributes {
        switch style {
        case .none:
            return TextAttributes(font: defaultFont, textColor: .white)
        case .bold10px,
             .bold11px,
             .bold12px,
             .bold13px,
             .bold14px,
             .bold15px,
             .bold16px,
             .bold18px,
             .bold20px,
             .bold24px,
             .bold30px,
             .bold36px,
             .bold40px:
            return styleBold(style: style)
        case .medium40px:
            return styleMedium(style: style)
        case .regular9px,
             .regular11px,
             .regular12px,
             .regular13px,
             .regular14px,
             .regular15px,
             .regular16px,
             .regular18px,
             .regular20px:
            return styleRegular(style: style)
        }
    }

    private func styleBold(style: TextsStyles) -> TextAttributes {
        return makeBold(of: CGFloat(style.rawValue))
    }

    private func styleMedium(style: TextsStyles) -> TextAttributes {
        return makeMedium(of: CGFloat(style.rawValue - mediumSizeDelta))
    }

    private func styleRegular(style: TextsStyles) -> TextAttributes {
        return makeRegular(of: CGFloat(style.rawValue - regularSizeDelta))
    }

    // MARK: - Bold
    
    private func makeBold(of size: CGFloat) -> TextAttributes {
        let font = R.font.interBold(size: size) ?? defaultFont
        return TextAttributes(font: font)
    }
    
    // MARK: - Regular

    private func makeRegular(of size: CGFloat) -> TextAttributes {
        let font = R.font.interRegular(size: size) ?? defaultFont
        return TextAttributes(font: font)
    }

    // MARK: - Medium
     
    private func makeMedium(of size: CGFloat) -> TextAttributes {
        let font = R.font.interMedium(size: size) ?? defaultFont
        return TextAttributes(font: font)
    }
}

extension TextsStyles {
    init?(style: TextsStyles) {
        self = style
    }
}
