//
//  CourseListView.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/18/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct CourseListView: View {
    @State private var courses = CourseViewModel.createWithData().courses
    @State private var active = false
    @State private var activeIndex = -1
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                    
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseItemView(
                                course: self.courses[index],
                                currentIndex: index,
                                active: self.$active, show: self.$courses[index].show,
                                activeIndex: self.$activeIndex
                            )
                                .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active)
            .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
