//
// Created by Sune Riedel on 28/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell, MovieView {
    var title: String {
        set {
            self.textLabel?.text = newValue
        }
        get {
            self.textLabel?.text ?? "N/A"
        }
    }

    var posterData: Data? {
        set {
            DispatchQueue.main.async {
                guard let newData = newValue else {
                    self.imageView?.image = nil
                    return
                }
                self.imageView?.image = UIImage(data: newData) ?? nil
            }
        }
        get {
            self.imageView?.image?.pngData()
        }
    }

    var releaseDate: String {
        set {
            self.detailTextLabel?.text = newValue
        }
        get {
            self.detailTextLabel?.text ?? "N/A"
        }
    }

    var voteAverage: String {
        set {
            self.acLabel.text = newValue
        }
        get {
            self.acLabel.text ?? "N/A"
        }
    }

    private let acLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        label.text = "x.x"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 60.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.accessoryView = self.acLabel
        self.textLabel?.numberOfLines = 3
        self.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        self.imageView?.layer.borderWidth = 1.0
        self.imageView?.layer.borderColor = UIColor.white.cgColor
        self.imageView?.layer.cornerRadius = 10.0
        self.imageView?.backgroundColor = .clear
        self.imageView?.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
