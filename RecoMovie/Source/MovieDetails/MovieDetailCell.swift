//
// Created by Sune Riedel on 28/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 11.0)
        titleLabel.textColor = .gray
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    private let detailLabel: UILabel = {
        let detailLabel = UILabel(frame: .zero)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.font = UIFont.systemFont(ofSize: 17.0)
        detailLabel.numberOfLines = 0
        return detailLabel
    }()

    var title: String {
        set {
            self.titleLabel.text = newValue
        }
        get {
            self.titleLabel.text ?? "N/A"
        }
    }

    var detailText: String {
        set {
            self.detailLabel.text = newValue
        }
        get {
            self.detailLabel.text ?? "N/A"
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? = nil) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailLabel)
        self.titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.detailLabel.topAnchor, constant: -5.0),
            self.detailLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.detailLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.detailLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
