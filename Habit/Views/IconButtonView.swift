//
//  IconButtonView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct IconButtonView: View {
    var systemName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName) // Replace with your icon name
                .padding() // Add padding around the icon
                .background(Theme.Color.gray600) // Set the background color
                .foregroundColor(.white) // Set the icon color
                .shadow(radius: 10) // Optional: Add a shadow for depth
                .cornerRadius(14.0)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    IconButtonView(systemName: "pencil", action: {
        print("Clicked")
    })
}
