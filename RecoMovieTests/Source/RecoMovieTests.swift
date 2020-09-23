//
//  RecoMovieTests.swift
//  RecoMovieTests
//
//  Created by Sune Riedel on 15/09/2020.
//  Copyright © 2020 Sune Riedel. All rights reserved.
//

import XCTest
@testable import RecoMovie

class RecoMovieTests: XCTestCase {
    func testModelStructures() throws {
        if let jsonData = self.loadDataFromLocalResource(named: "movies.json") {
            do {
                let resultPage = try JSONDecoder().decode(ResultPage.self, from: jsonData)
                XCTAssertEqual(resultPage.results.count, 2, "Unexpected result size")
                XCTAssertEqual(resultPage.page, 1, "Unexpected page number")
                XCTAssertEqual(resultPage.totalPages, 500, "Unexpected total number of pages")
                XCTAssertEqual(resultPage.totalResults, 10000, "Unexpected total number of results")
                
                let movie1 = resultPage.results[0]
                XCTAssertEqual(movie1.popularity, 2028.856, "Unexpected movie popularity")
                XCTAssertEqual(movie1.voteCount, 1, "Unexpected movie vote count")
                XCTAssertEqual(movie1.video, false, "Unexpected movie video attribute")
                XCTAssertEqual(movie1.posterPath, "/6CoRTJTmijhBLJTUNoVSUNxZMEI.jpg", "Unexpected movie poster path")
                XCTAssertEqual(movie1.originalLanguage, "en", "Unexpected movie original language")
                XCTAssertEqual(movie1.originalTitle, "Money Plane", "Unexpected movie original title")
                XCTAssertEqual(movie1.genreIDs, [28], "Unexpected movie genres")
                XCTAssertEqual(movie1.title, "Money Plane", "Unexpected movie title")
                XCTAssertEqual(movie1.voteAverage, 8.5, "Unexpected movie vote average")
                XCTAssertEqual(movie1.overview, "A professional thief with $40 million in debt and his family's life on the line must commit one final heist - rob a futuristic airborne casino filled with the world's most dangerous criminals.", "Unexpected movie overview")
                XCTAssertEqual(movie1.releaseDate, "2020-09-29", "Unexpected movie release date")

                let movie2 = resultPage.results[1]
                XCTAssertEqual(movie2.popularity, 1526.825, "Unexpected movie popularity")
                XCTAssertEqual(movie2.voteCount, 1875, "Unexpected movie vote count")
                XCTAssertEqual(movie2.video, false, "Unexpected movie video attribute")
                XCTAssertEqual(movie2.posterPath, "/aKx1ARwG55zZ0GpRvU2WrGrCG9o.jpg", "Unexpected movie poster path")
                XCTAssertEqual(movie2.originalLanguage, "en", "Unexpected movie original language")
                XCTAssertEqual(movie2.originalTitle, "Mulan", "Unexpected movie original title")
                XCTAssertEqual(movie2.genreIDs, [28, 12, 18, 14], "Unexpected movie genres")
                XCTAssertEqual(movie2.title, "Mulan", "Unexpected movie title")
                XCTAssertEqual(movie2.voteAverage, 7.5, "Unexpected movie vote average")
                XCTAssertEqual(movie2.overview, "When the Emperor of China issues a decree that one man per family must serve in the Imperial Chinese Army to defend the country from Huns, Hua Mulan, the eldest daughter of an honored warrior, steps in to take the place of her ailing father. She is spirited, determined and quick on her feet. Disguised as a man by the name of Hua Jun, she is tested every step of the way and must harness her innermost strength and embrace her true potential.")
                XCTAssertEqual(movie2.releaseDate, "2020-09-10", "Unexpected movie release date")
            }
            catch _ {
                print("errored!")
            }
        }
    }

    // helper function for loading json mock data
    func loadDataFromLocalResource(named resource: String) -> Data? {
        let components = resource.split(separator: ".")
        if components.count == 2 {
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.path(forResource: String(components[0]), ofType: String(components[1])) {
                do {
                    return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                }
                catch _ { }
            }
        }
        return nil
    }
}
