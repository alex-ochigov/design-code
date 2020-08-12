//
//  CertificateScreen.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/12/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct CertificateScreen: View {
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: 20)

            BackCardView()
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y:  -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(10))
                .rotation3DEffect(.degrees(10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
            
            BackCardView()
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -20)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(5))
                .rotation3DEffect(.degrees(5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .blendMode(.hardLight)
            
            BottomCardView()
                .blur(radius: 20)
        }
    }
}

struct CertificateScreen_Previews: PreviewProvider {
    static var previews: some View {
        CertificateScreen()
    }
}
