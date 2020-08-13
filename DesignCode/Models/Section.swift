//
//  Section.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/12/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation
import SwiftUI

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}
