//
//  OneHabitAnalytics.swift
//  Habit
//
//  Created by Ayush Agarwal on 1/28/24.
//

import SwiftUI

struct OneHabitAnalytics: View {
    
    @ObservedObject var habit: Habit
    @State private var date = Date()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("72%") // 4 week consistency
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text("4 Week")
                        .foregroundStyle(.white)
                    Text("Consistency")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 15)
                .frame(alignment: .top)
                .padding(.vertical)
                .padding(16)
                .background(Theme.Color.gray600.opacity(0.7))
                .cornerRadius(24)
                Spacer()
                
                VStack(alignment: .center) {
                    Text("4") // 4 week consistency
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text("Day")
                        .foregroundStyle(.white)
                    Text("Streak")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 35)
                .frame(alignment: .top)
                .padding(.vertical)
                .padding(16)
                .background(Theme.Color.gray600.opacity(0.7))
                .cornerRadius(24)
                Spacer()
            }
            
            Spacer()
            
            VStack(spacing: 20) { // Adjust spacing as needed
                Spacer()
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .frame(height: 200) // Adjust the height as needed
                .padding()
                .padding(.horizontal, 12)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}


#Preview {
    OneHabitAnalytics(habit: Habit(name:"TEST"))
}
