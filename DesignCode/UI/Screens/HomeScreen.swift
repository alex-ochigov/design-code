//
//  HomeScreen.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/12/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel = SectionViewModel.createWithData()
    @ObservedObject var postsViewModel = PostViewMode()
    @State private var showProfile = false
    @State private var viewState: CGSize = .zero
    @State private var showUpdate = false
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
                ScrollView {
                    HStack(spacing: 12) {
                        Text("Watching")
                            .font(.system(size: 28, weight: .bold))
                        
                        Spacer()
                        AvatarView(showProfile: $showProfile)
                        BellButtonView(showUpdate: $showUpdate)
                    }
                    .padding(.horizontal)
                    .padding(.leading, 14)
                    .padding(.top, 30)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            CardShadowView {
                                RingView(show: .constant(true), colorFrom: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), colorTo: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 69)
                                VStack(alignment: .leading, spacing: 4) {
                                     Text("6 minute left")
                                         .font(.subheadline)
                                         .fontWeight(.bold)
                                     Text("watched 10 minutes today")
                                         .font(.caption)
                                 }
                            }

                            CardShadowView {
                                RingView(show: .constant(true), colorFrom: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), colorTo: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, height: 32, percent: 48)
                            }
                            
                            CardShadowView {
                                RingView(show: .constant(true), colorFrom: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), colorTo: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), width: 32, height: 32, percent: 25)
                            }
                        }
                        .onTapGesture { self.showContent.toggle() }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.section) { section in
                                GeometryReader { geometry in
                                    SectionView(section: section)
                                        .rotation3DEffect(.degrees(Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10.0, z: 0))
                                }
                                .frame(width: 275, height: 275)
                            }
                        }
                        .padding(30)
                        .padding(.bottom, 30)
                    }
                    .offset(y: -30)
                    
                    HStack {
                        Text("Courses")
                            .font(.title).bold()
                        Spacer()
                    }
                    .padding(.leading, 30)
                    .offset(y: -60)
                    
                    SectionView(section: viewModel.section[2], width: screen.width - 60, height: 275)
                        .offset(y: -60)
                    
                    Spacer()
                }
                .modifier(HomeScreenStyles(showProfile: $showProfile))

            
            MenuView()
                .modifier(MenuViewStyles(showProfile: $showProfile, viewState: $viewState))
                .onTapGesture { self.showProfile.toggle() }
                .gesture(dragGesture())
            
            if showContent {
                Color.white.edgesIgnoringSafeArea(.all)
                CertificatesScreen()
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .onTapGesture { self.showContent = false }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
            }
        }
    }
    
    private func dragGesture() -> some Gesture {
        DragGesture().onChanged { value in
            self.viewState = value.translation
        }.onEnded { value in
            if (self.viewState.height > 50) {
                self.showProfile = false
            }
            self.viewState = .zero
        }
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: { self.showProfile.toggle() }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(Color.white)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct BellButtonView: View {
    @Binding var showUpdate: Bool
    
    var body: some View {
        Button(action: { self.showUpdate.toggle() }) {
            Image(systemName: "bell")
                .renderingMode(.original)
                .font(.system(size: 16, weight: .medium))
                .frame(width: 36, height: 36)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
        }
        .sheet(isPresented: $showUpdate) {
            UpdateListScreen()
        }
    }
}

struct CardShadowView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack(spacing: 12) {
            content
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

fileprivate struct HomeScreenStyles: ViewModifier {
    @Binding var showProfile: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 44)
            .background(
                VStack {
                    LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 200)
                    Spacer()
                }
                .background(Color.white)
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .offset(y: showProfile ? -450 : 0)
            .rotation3DEffect(.degrees(showProfile ? -10 : 0), axis: (x: 10, y: 0, z: 0))
            .scaleEffect(showProfile ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct MenuViewStyles: ViewModifier {
    @Binding var showProfile: Bool
    @Binding var viewState: CGSize
    
    func body(content: Content) -> some View {
        content
            .background(Color.black.opacity(0.001))
            .offset(y: showProfile ? 0 : screen.height)
            .offset(y: viewState.height)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: SectionViewModel.createWithData())
    }
}
