//
//  AnalyticsView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct AnalyticsView: View {
    
    @EnvironmentObject var habitVM: HabitViewModel
    
    var body: some View {
        TabView {
            ForEach(habitVM.habitHistorys, id: \.self) { habitHistory in
                VStack {
                    Text(habitHistory.getTodaysHabit()!.name)
                        .font(.title.bold())
                        .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
        .tabViewStyle(.page)
        
        
    }
}

#Preview {
    AnalyticsView()
}
