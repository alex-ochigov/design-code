//
//  CertificatesScreen.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/12/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct CertificatesScreen: View {
    @State private var show = false
    @State private var viewState: CGSize = .zero
    @State private var showCard = false
    @State private var bottomState: CGSize = .zero

    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
            )

            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .frame(width: showCard ? 375 : 340, height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(self.dragCardgGesture())
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(dragBottomCardGesture())
        }
    }
    
    private func dragCardgGesture() -> some Gesture {
        DragGesture().onChanged { value in
            if !self.showCard {
                self.viewState = value.translation
            }
        }
        .onEnded { value in
            self.viewState = .zero
        }
    }
    
    private func dragBottomCardGesture() -> some Gesture {
        DragGesture().onChanged { value in
            self.bottomState = value.translation
        }
        .onEnded { value in
            if self.bottomState.height > 50 {
                self.bottomState = .zero
                self.showCard = false
            }
        }
    }
}

struct CertificateScreen_Previews: PreviewProvider {
    static var previews: some View {
        CertificatesScreen()
    }
}
