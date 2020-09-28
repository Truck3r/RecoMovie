//
// Created by Sune Riedel on 28/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

extension String {
    func reformatDateString() -> String {
        // parsing the string date from the API
        let dateParser = DateFormatter()
        dateParser.dateFormat = "yyyy-MM-dd"

        // formatting the date back to a nice display string
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .long
        displayFormatter.timeStyle = .none

        let date = dateParser.date(from: self) ?? Date()
        return displayFormatter.string(from: date)
    }
}
