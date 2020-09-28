//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

class MovieListNetworkDataSource: MovieListDataSource {
    // adjust this to decide when to start preloading (when element of count - x is requested, we initiate load of next page)
    private static let pageLoadThreshold = 3

    private let networkInterface: NetworkInterface

    private(set) var totalCount: Int = .max

    private var pageSize = -1

    private var nextPage = 0

    private var movies: [Movie] = []

    var count: Int {
        movies.count
    }

    var dataUpdatedCallback: ((Int, Int) -> ())? = nil

    init(networkInterface: NetworkInterface) {
        self.networkInterface = networkInterface
        fetchNextPage()
    }

    subscript(index: Int) -> Movie? {
        guard index >= 0 && index < movies.count else {
            return nil
        }
        if index >= movies.count - (1 + MovieListNetworkDataSource.pageLoadThreshold) {
            self.fetchNextPage()
        }
        return self.movies[index]
    }

    private func fetchNextPage() {
        // check if we're already loading next page
        guard self.movies.count / pageSize == nextPage else {
            return
        }
        // don't fetch beyond the total available results
        guard self.movies.count < totalCount else {
            return
        }
        nextPage += 1
        self.networkInterface.fetchJSON("https://api.themoviedb.org/3/movie/popular?api_key=99407f749a32bdc2144c7fdaedabd570&page=\(nextPage)", codable: ResultPage.self) {
            resultPage, response, error in
            if let page = resultPage {
                if self.pageSize == -1 {
                    self.pageSize = page.results.count
                    self.totalCount = page.totalResults
                }
                let begin = self.movies.count
                self.movies += page.results
                // notify the observer of the data source (if set), that new data is available
                self.dataUpdatedCallback?(begin, self.movies.count - 1)
            }
            else if error != nil {
                // TODO: this would be a good place to do some actual error handling
            }
        }
    }
}
