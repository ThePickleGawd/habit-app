//
//  OneHabitAnalytics.swift
//  Habit
//
//  Created by Ayush Agarwal on 1/28/24.
//

import SwiftUI

struct OneHabitAnalytics: View {
    @ObservedObject var habit: Habit
    @EnvironmentObject var habitVM: HabitViewModel
    @State var date: [DateComponents]
    
    func getReverseHistory() -> [HabitData] {
        return habitVM.habitHistorys.first(
            where: { $0.unique_id == habit.id }
        )?.history.reversed() ?? []
    }
    
    func findConsistency() -> String {
        let fourWeeksAgo = Date.now.addingTimeInterval(-3600 * 24 * 28)
        
        var total = 0
        var completed = 0
        for habitData in getReverseHistory() {
            if habitData.creationDate < fourWeeksAgo {
                break
            }
            
            total += 1
            if habitData.completed ?? false {
                completed += 1
            }
        }
        if (total == 0) {
            return "N/A"
        }
        return String(completed * 100 / total) + "%"
    }
    
    func findStreak() -> Int {
        var reverseHistory = getReverseHistory()
        
        if reverseHistory.isEmpty {
            return 0
        }
        
        var streak = 0
        if Calendar.current.isDateInToday(reverseHistory[0].creationDate) {
            if reverseHistory[0].completed ?? false {
                streak = 1
            }
            reverseHistory.remove(at: 0)
        }
        
        var prevDay = Date.now
        
        for habitData in reverseHistory {
            prevDay.addTimeInterval(-3600 * 24)
            if (
                (habitData.completed ?? false) &&
                Calendar.current.isDate(habitData.creationDate, inSameDayAs: prevDay)
            ) {
                streak += 1
            } else {
                return streak
            }
        }
        return streak
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text(findConsistency()).font(.largeTitle.bold())
                Text("    4-week consistency")
                Spacer()
            }
            .padding(.vertical)
            .padding(16)
            .background(Theme.Color.gray600.opacity(0.7))
            .cornerRadius(24)
            
            Spacer()
            
            HStack(alignment: .center) {
                Spacer()
                Text(String(findStreak())).font(.largeTitle.bold())
                Text("    day streak")
                Spacer()
            }
            .padding(.vertical)
            .padding(16)
            .background(Theme.Color.gray600.opacity(0.7))
            .cornerRadius(24)
            
            Spacer(minLength: 480)
        }.padding(24)
    }
}

#Preview {
    OneHabitAnalytics(habit: Habit(name: "TEST"), date: []).previewSetup()
}
