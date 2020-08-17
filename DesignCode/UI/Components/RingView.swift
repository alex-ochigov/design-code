//
//  RingView.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/17/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct RingView: View {
    private var defaultSize: CGFloat = 44
    
    public var colorFrom = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    public var colorTo = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    public var width: CGFloat = 44
    public var height: CGFloat = 44
    public var percent: CGFloat = 88
    
    var body: some View {
        let multiplier = width / defaultSize
        let progress = 1 - (percent / 100)
        
       return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)

            Circle()
                .trim(from: progress, to: 1)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(colorFrom), Color(colorTo)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(
                        lineWidth: 5 * multiplier,
                        lineCap: .round,
                        lineJoin: .round,
                        miterLimit: .infinity,
                        dash: [20, 0],
                        dashPhase: 0
                    )
                )
                .rotationEffect(.degrees(90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(colorTo).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)
            
            Text("\(Int(percent))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
