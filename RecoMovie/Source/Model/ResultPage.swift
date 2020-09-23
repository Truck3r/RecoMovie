//
// Created by Sune Riedel on 21/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

struct ResultPage: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int

    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}
