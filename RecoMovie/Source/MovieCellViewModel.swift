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

    // parsing the string date from the API
    private let dateParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // formatting the date back to a nice display string
    private let displayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()

    init(movie: Movie, networkInterface: NetworkInterface) {
        self.movie = movie
        self.networkInterface = networkInterface
    }

    func bind(to view: MovieView) {
        view.title = movie.title
        let date = self.dateParser.date(from: movie.releaseDate) ?? Date()
        view.releaseDate = "Released: \(self.displayFormatter.string(from: date))"
        view.voteAverage = String(format: "%.1f", movie.voteAverage)

        self.networkInterface.fetchImageData("https://image.tmdb.org/t/p/w154\(movie.posterPath)") { data, response, error in
            view.posterData = data
        }
    }
}
