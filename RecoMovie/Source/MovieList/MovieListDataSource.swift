//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

protocol MovieListDataSource: class {
    // basically you only need to access the data source as an array
    var count: Int { get }
    subscript(index: Int) -> Movie? { get }

    // callback to register, if consumer wishes to be notified when data source content is updated
    var dataUpdatedCallback: ((Int, Int) -> Void)? { get set }
}
