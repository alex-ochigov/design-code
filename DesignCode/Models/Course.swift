//
//  Course.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/13/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct Course: Identifiable {
       var id = UUID()
       var title: String
       var subtitle: String
       var image: UIImage
       var logo: UIImage
       var color: UIColor
       var show: Bool
}
