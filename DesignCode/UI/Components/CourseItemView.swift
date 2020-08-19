//
//  CourseListItemView.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/19/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct CourseItemView: View {
    var course: Course
    var currentIndex: Int
    
    @Binding var active: Bool
    @Binding var show: Bool
    @Binding var activeIndex: Int
    
    @State private var gestureDragOffset: CGSize = .zero

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title).bold()
                    
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")

                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                    }
                    
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(closeOnTap())
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.gestureDragOffset.height / 1000)
        .rotation3DEffect(.degrees(Double(self.gestureDragOffset.height / 10)), axis: (x: 0, y: 10, z: 0))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
    
    private func closeOnTap() -> some Gesture {
        TapGesture().onEnded {
            self.show.toggle()
            self.active.toggle()
            if self.show {
                self.activeIndex = self.currentIndex
            } else {
                self.activeIndex = -1
            }
        }
    }
    
    private func closeOnDrag() -> some Gesture {
        DragGesture().onChanged { value in
            if self.show, value.translation.height < 300, value.translation.height > 0 {
                self.gestureDragOffset = value.translation
            }
        }
        .onEnded { value in
            if self.gestureDragOffset.height > 50 {
                self.show = false
                self.active = false
                self.activeIndex = -1
            }
            self.gestureDragOffset = .zero
        }
    }
}
