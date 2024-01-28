//
//  CountHabit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

class CountHabit : Habit {
    @Published var progress: Int = 0
    @Published var goal: Int
    
    init(name: String, id: UUID = UUID(),creationDate: Date = Date(), activeDays: Set<Weekday> = [], goal: Int, progress: Int = 0) {
        self.goal = goal
        self.progress = progress
                
        super.init(name: name, id: id, creationDate: creationDate, activeDays: activeDays)
    }
    
    override func getProgressString() -> String {
        return "\(self.progress) / \(self.goal)"
    }
    
    override func actionButtonClicked() {
        print("Action button clicked CountHabit")
        if (self.progress < self.goal) {
            self.progress += 1
        }
    }
    
    override func toHabitData() -> HabitData {
        return HabitData(habitType: .countHabit, name: name, id: id, creationDate: creationDate, progress: progress, goal: goal)
    }
}
