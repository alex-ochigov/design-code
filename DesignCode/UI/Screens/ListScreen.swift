//
//  ListScreen.swift
//  DesignCode
//
//  Created by Alex Ochigov on 8/13/20.
//  Copyright © 2020 Alex Ochigov. All rights reserved.
//

import SwiftUI

struct UpdateListScreen: View {
    private var viewModel = UpdateViewModel.createWithData()
    
    var body: some View {
        NavigationView {
            List(viewModel.updates) { update in
                NavigationLink(destination: UpdateDetailScreen(update: update)) {
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 4)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            Text(update.text)
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            
                            Text(update.date)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationBarTitle(Text("Updates"))
        }
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdateListScreen()
    }
}
