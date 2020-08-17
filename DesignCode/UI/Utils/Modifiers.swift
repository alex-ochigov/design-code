//
//  Modifiers.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/17/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct FontModifier: ViewModifier {
    public var style: Font.TextStyle = .body
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .rounded))
    }
}
