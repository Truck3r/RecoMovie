//
//  ViewController.swift
//  RecoMovie
//
//  Created by Sune Riedel on 15/09/2020.
//  Copyright © 2020 Sune Riedel. All rights reserved.
//

import UIKit

class MovieDetailController: UITableViewController, MovieDetailView {
    private var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 350.0))
        image.contentMode = .scaleAspectFit

        return image
    }()

    var posterData: Data? {
        set {
            DispatchQueue.main.async {
                guard let newData = newValue else {
                    self.imageView.image = nil
                    self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
                    self.tableView.reloadData()
                    return
                }
                self.imageView.image = UIImage(data: newData) ?? nil
                self.tableView.tableHeaderView = self.imageView.image != nil ? self.imageView : UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
                self.tableView.reloadData()
            }
        }
        get {
            self.imageView.image?.pngData()
        }
    }
    var additionalData: [(String, String)] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(MovieDetailCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = .none
        self.tableView.tableHeaderView = self.imageView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.additionalData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieDetailCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieDetailCell else {
            return UITableViewCell()
        }

        cell.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.95, alpha: 1.0)
        let props = additionalData[indexPath.row]

        cell.title = props.0
        cell.detailText = props.1

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
