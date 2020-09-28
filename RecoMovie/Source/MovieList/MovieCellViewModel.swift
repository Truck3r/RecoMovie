//
// Created by Sune Riedel on 28/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

protocol MovieView: class {
    var title: String { get set }
    var posterData: Data? { get set }
    var releaseDate: String { get set }
    var voteAverage: String { get set }
}

struct MovieCellViewModel {
    // model object
    private let movie: Movie
    // network interface for fetching additional data (poster images)
    private let networkInterface: NetworkInterface

    init(movie: Movie, networkInterface: NetworkInterface) {
        self.movie = movie
        self.networkInterface = networkInterface
    }

    func bind(to view: MovieView) {
        view.title = movie.title
        view.releaseDate = "Released: \(movie.releaseDate.reformatDateString())"
        view.voteAverage = String(format: "%.1f", movie.voteAverage)

        if let posterPath = movie.posterPath {
            self.networkInterface.fetchImageData("https://image.tmdb.org/t/p/w154\(posterPath)") { data, response, error in
                view.posterData = data
            }
        }
    }
}
