//
//  RootView.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/13/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeScreen().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home ")
            }
            CertificatesScreen().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
