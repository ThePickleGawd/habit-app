//
//  HomeView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Habits")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

#Preview {
    HomeView()
}
