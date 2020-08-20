//
//  PostViewModel.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/20/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation
import Combine

class PostViewMode: ObservableObject {
    @Published private(set) var posts: [Post] = []
    
    private var cancellationToken: AnyCancellable?
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        cancellationToken = JSONPlaceholderAPI.getPosts()
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.posts = $0
            })
    }
}
