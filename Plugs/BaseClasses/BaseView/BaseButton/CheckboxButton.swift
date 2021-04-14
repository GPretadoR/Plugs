//
//  CheckboxButton.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 8/31/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class CheckboxButton: BaseButton {

    var selectedIcon: UIImage? {
        didSet {
            let tintedImage = selectedIcon?.withRenderingMode(.alwaysTemplate)
            setBackgroundImage(tintedImage, for: .selected)
        }
    }

    var deselectedIcon: UIImage? {
        didSet {
            setBackgroundImage(deselectedIcon, for: .normal)
        }
    }

    var checkBoxDidChange: ((Bool) -> Void)?

    override func setup() {
        super.setup()
        addTarget(self, action: #selector(checkBoxTapped(_ :)), for: .touchUpInside)
        configureDefaultValues()
    }

    private func configureDefaultValues() {
        tintColor = .systemBlue
    }

    @objc private func checkBoxTapped(_ sender: Any) {
        isSelected = !isSelected
        checkBoxDidChange?(isSelected)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: -10, dy: -10).contains(point)
    }
}
