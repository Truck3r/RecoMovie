//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

class RemoteNetwork : NetworkInterface {
    private let decoder: JSONDecoder = JSONDecoder()
    fileprivate let dataSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpShouldUsePipelining = true
        return URLSession(configuration: config)
    }()

    func fetchJSON<T>(_ url: String, codable: T.Type, completion: @escaping (T?, RemoteResponse?, RemoteError?) -> Void) where T : Decodable {
        guard let u = URL(string: url) else {
            completion(nil, nil, RemoteError.urlError)
            return
        }
        let task = self.dataSession.dataTask(with: u) {
            data, response, error in
            var err: RemoteError? = error != nil ? .networkError : nil
            let remoteResponse = RemoteResponse(urlResponse: response)
            var json: T?
            if let d = data {
                do {
                    json = try self.decoder.decode(codable, from: d)
                }
                catch _ {
                    err = RemoteError.contentError
                }
            }
            completion(json, remoteResponse, err)
        }
        task.resume()
    }
}
