//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import Foundation

class TestNetwork: NetworkInterface {
    func fetchJSON<T>(_ url: String, codable: T.Type, completion: @escaping (T?, RemoteResponse?, RemoteError?) -> ()) where T: Decodable {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let page = Int(url.suffix(1)) {
                if let jsonData = self.loadDataFromLocalResource(named: "movies\(page).json") {
                    do {
                        let json = try JSONDecoder().decode(codable, from: jsonData)
                        completion(json, nil, nil)
                    } catch _ {
                        completion(nil, nil, .contentError)
                    }
                } else {
                    completion(nil, nil, .dataError)
                }
            } else {
                completion(nil, nil, .urlError)
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
                } catch _ {
                }
            }
        }
        return nil
    }

}