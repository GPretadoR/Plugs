//
//  BaseTableViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/5/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        guard let label = textLabel as? AppLabel else { return }
        setStyle(label: label, style: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setStyle(label: AppLabel, style: TextsStyles) {
        label.style(for: style)
    }
}
