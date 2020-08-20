//
//  Post.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/20/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}
