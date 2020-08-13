//
//  Update.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/13/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}
