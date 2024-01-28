//
//  HabitListItemView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct HabitListItemView: View {
    @ObservedObject var habit: Habit
    
    var body: some View {
        HStack {
            Image(systemName: "pencil")
                .padding()
                .background(Theme.Color.gray800)
                .cornerRadius(16)
                .imageScale(.large)
            VStack(alignment: .leading) {
                Text(habit.name)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .fixedSize()
                Text(habit.getProgressString())
                    .foregroundStyle(Theme.Color.gray300)
                    .font(.caption)
            }.padding(.horizontal)
            Spacer()
                .padding(.horizontal)
            IconButtonView(systemName: "plus", action: {
                habit.actionButtonClicked()
            })
        }
        .padding(16)
        .background(Theme.Color.gray600.opacity(0.7))
        .cornerRadius(24)
    }
}

#Preview {
    HabitListItemView(habit: CountHabit(name: "Test", goal: 1)).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/).padding()
}
