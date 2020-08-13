//
//  UpdateViewModel.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/13/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import Foundation
import Combine

class UpdateViewModel: ObservableObject {
    @Published public var updates: [Update]
    
    init(updates: [Update]) {
        self.updates = updates
    }
    
    public static func createWithData() -> UpdateViewModel {
        UpdateViewModel(updates: [
            Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
            Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
            Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
            Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
            Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
        ])
    }
    
    func add(image: String, title: String, text: String, date: String) {
        self.updates.append(Update(id: UUID(), image: image, title: title, text: text, date: date))
    }
    
    func delete(_ update: Update) {
        self.updates = self.updates.filter { upd in
            return upd.id != update.id
        }
    }
}
