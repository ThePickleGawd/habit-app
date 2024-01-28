//
//  HabitSettingsView.swift
//  Habit
//
//  Created by Dylan Lu on 1/28/24.
//

import SwiftUI

struct HabitSettingsView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    
    @ObservedObject var habit: Habit
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(habit.name)
                    .font(.system(size: 24))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                
                Spacer()
                
                IconButtonView(systemName: "pencil", action: {
                    
                })
                
                IconButtonView(systemName: "trash", action: {
                    print("Trying to delete \(habit.id)")
                    habitVM.deleteHabit(habit)
                })
            }
            .padding(24)
            Spacer()
        }
    }
}
