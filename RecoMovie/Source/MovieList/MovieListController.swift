//
//  ViewController.swift
//  RecoMovie
//
//  Created by Sune Riedel on 15/09/2020.
//  Copyright © 2020 Sune Riedel. All rights reserved.
//

import UIKit

class MovieListController: UITableViewController {
    private unowned let dataSource: MovieListDataSource
    private unowned let networkInterface: NetworkInterface

    init(dataSource: MovieListDataSource, networkInterface: NetworkInterface) {
        self.dataSource = dataSource
        self.networkInterface = networkInterface
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "Back"
        self.title = "Popular Movies"
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = 120.0
        self.tableView.separatorStyle = .none
        self.dataSource.dataUpdatedCallback = { from, to in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// data source
extension MovieListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieCell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }

        if let movie = self.dataSource[indexPath.row] {
            let viewModel = MovieCellViewModel(movie: movie, networkInterface: networkInterface)
            viewModel.bind(to: cell)
        } else {
            cell.title = "N/A"
        }

        cell.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.95, alpha: 1.0)
        cell.imageView?.layer.borderColor = cell.backgroundColor?.cgColor

        return cell
    }

}

// delegate methods
extension MovieListController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if let movie = self.dataSource[indexPath.row] {
            let detailController = MovieDetailController()
            self.navigationController?.pushViewController(detailController, animated: true)

            let viewModel = MovieDetailViewModel(movie: movie, networkInterface: self.networkInterface)
            viewModel.bind(to: detailController)
        }
    }
}
