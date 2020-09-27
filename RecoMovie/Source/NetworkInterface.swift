//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

enum RemoteError: Error {
    case urlError
    case networkError
    case dataError
    case contentError
}

struct RemoteResponse {
    let code: Int
    let headers: [AnyHashable: Any]

    init?(urlResponse: URLResponse?) {
        guard let resp = urlResponse as? HTTPURLResponse else {
            return nil
        }
        self.code = resp.statusCode
        self.headers = resp.allHeaderFields
    }
}

protocol NetworkInterface: class {
    func fetchJSON<T>(_ url: String, codable: T.Type, completion: @escaping (T?, RemoteResponse?, RemoteError?) -> Void) where T : Decodable
}
