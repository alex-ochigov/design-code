//
//  CourseViewModel.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/18/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation
import Combine

class CourseViewModel: ObservableObject {
    @Published public var courses: [Course]
    
    init(courses: [Course]) {
        self.courses = courses
    }
    
    public static func createWithData() -> CourseViewModel {
        CourseViewModel(courses: [
           Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
           Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
           Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
        ])
    }
}
