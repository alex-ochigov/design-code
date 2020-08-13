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
    @State private var showProfile = false
    @State private var viewState: CGSize = .zero
    @State private var showUpdate = false
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
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
                Spacer()
            }
            .modifier(HomeScreenStyles(showProfile: $showProfile))
            
            MenuView()
                .modifier(MenuViewStyles(showProfile: $showProfile, viewState: $viewState))
                .onTapGesture { self.showProfile.toggle() }
                .gesture(dragGesture())
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
        .frame(width: 275, height: 275)
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

fileprivate struct HomeScreenStyles: ViewModifier {
    @Binding var showProfile: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 44)
            .background(Color.white)
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
            .offset(y: showProfile ? 0 : 1000)
            .offset(y: viewState.height)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: SectionViewModel.createWithData())
    }
}
