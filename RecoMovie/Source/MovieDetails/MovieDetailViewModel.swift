//
// Created by Sune Riedel on 28/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

protocol MovieDetailView: class {
    var posterData: Data? { get set }
    var title: String? { get set }
    var additionalData: [(String, String)] { get set }
}

struct MovieDetailViewModel {
    // model object
    private let movie: Movie
    // network interface for fetching additional data (poster images)
    private let networkInterface: NetworkInterface


    init(movie: Movie, networkInterface: NetworkInterface) {
        self.movie = movie
        self.networkInterface = networkInterface
    }

    func bind(to view: MovieDetailView) {
        view.title = movie.title
        var additionalData: [(String, String)] = []
        additionalData.append(("Title", movie.title))
        additionalData.append(("Release Date", self.movie.releaseDate.reformatDateString()))
        additionalData.append(("User Rating", String(format: "%.1f (%d votes)", movie.voteAverage, movie.voteCount)))
        additionalData.append(("Original Title", movie.originalTitle))
        additionalData.append(("Original Language", movie.originalLanguage))
        additionalData.append(("Summary", movie.overview))
        view.additionalData = additionalData

        if let posterPath = movie.posterPath {
            self.networkInterface.fetchImageData("https://image.tmdb.org/t/p/w500\(posterPath)") { data, response, error in
                view.posterData = data
            }
        }
    }
}
