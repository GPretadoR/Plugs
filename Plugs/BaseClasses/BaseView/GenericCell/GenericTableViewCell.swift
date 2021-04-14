//
//  GenericTableViewCell.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/11/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import UIKit
import SnapKit

final class GenericTableViewCell<View: UIView>: BaseTableViewCell {
    public var view = View()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(view)

        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
