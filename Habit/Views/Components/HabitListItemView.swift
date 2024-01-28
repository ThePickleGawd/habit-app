//
//  HabitListItemView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct HabitListItemView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    @ObservedObject var habit: Habit
    
    @State var habitSettingsOpen: Bool = false
    
    var body: some View {
        Button(action: {
            habitSettingsOpen = true
        }) {
            HStack {
                Image(systemName: "pencil")
                    .padding()
                    .background(Theme.Color.gray800)
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .imageScale(.large)
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .fixedSize()
                    Text(habit.getProgressString())
                        .foregroundStyle(Theme.Color.gray300)
                        .font(.caption)
                }.padding(.horizontal)
                Spacer()
                    .padding(.horizontal)
                IconButtonView(systemName: "plus", action: {
                    habit.actionButtonClicked()
                    habitVM.saveHabits()
                })
            }
            .padding(16)
            .background(Theme.Color.gray600.opacity(0.7))
            .cornerRadius(24)
        }
        .sheet(isPresented: $habitSettingsOpen) {
            HabitSettingsView(isPresented: $habitSettingsOpen)
        }
    }
}

#Preview {
    HabitListItemView(habit: CountHabit(name: "Test", goal: 1)).previewSetup().padding()
}
