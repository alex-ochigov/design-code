//
//  JSONPlaceholderService.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/20/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation
import Combine

enum JSONPlaceholderAPI {
    static let client = APIClient()
    static let base = URL(string: "https://jsonplaceholder.typicode.com")!
}

extension JSONPlaceholderAPI {
    
    static func getPosts() -> AnyPublisher<[Post], Error> {
        return run(URLRequest(url: base.appendingPathComponent("/posts")))
    }
    
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return client.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
