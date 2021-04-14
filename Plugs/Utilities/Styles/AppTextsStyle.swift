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

enum TextsStyles {
    case none

    // Bold
    case bold10px
    case bold11px
    case bold12px
    case bold13px
    case bold14px
    case bold15px
    case bold16px
    case bold18px
    case bold20px
    case bold24px
    case bold30px
    case bold36px
    case bold40px

    // Medium
    case medium40px

    // Regular
    case regular9px
    case regular11px
    case regular12px
    case regular13px
    case regular14px
    case regular15px
    case regular16px
    case regular18px
    case regular20px

    private var defaultFont: UIFont {
        UIFont.systemFont(ofSize: 17)
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
        switch style {
        default:
            return TextAttributes(font: defaultFont, textColor: R.color.black())
        }
    }

    private func styleMedium(style: TextsStyles) -> TextAttributes {
        switch style {
        default:
            return TextAttributes(font: defaultFont, textColor: R.color.black())
        }
    }

    private func styleRegular(style: TextsStyles) -> TextAttributes {
        switch style {
        default:
            return TextAttributes(font: defaultFont, textColor: R.color.black())
        }
    }

    // MARK: - Bold
    /*
    private func makeBold10px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 10) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold11px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 11) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold12px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 12) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold13px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 13) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold14px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 14) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold15px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 15) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold16px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 16) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold18px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 18) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold20px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 20) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold24px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 24) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold30px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 30) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold36px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 36) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeBold40px() -> TextAttributes {
        let font = R.font.sfProTextBold(size: 40) ?? defaultFont
        return TextAttributes(font: font)
    }

    // MARK: - Regular

    private func makeRegular9px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 9) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular11px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 11) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular12px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 12) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular13px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 13) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular14px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 14) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular15px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 15) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular16px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 16) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular18px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 18) ?? defaultFont
        return TextAttributes(font: font)
    }

    private func makeRegular20px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 20) ?? defaultFont
        return TextAttributes(font: font)
    }

    // MARK: - Medium

    private func makeMedium40px() -> TextAttributes {
        let font = R.font.sfProTextRegular(size: 40) ?? defaultFont
        return TextAttributes(font: font)
    }
     */
}

extension TextsStyles {
    init?(style: TextsStyles) {
        self = style
    }
}
