//
//  HabitViewModel.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []

    init() {
        loadHabits()
    }

    func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: "habits"),
           let savedHabitData = try? JSONDecoder().decode([HabitData].self, from: data) {
            self.habits = savedHabitData.map { data in
                return Habit.fromHabitData(data)
            }
        }
    }
    
    func saveHabits() {
        let habitDataArray = habits.map { $0.toHabitData() }
        if let encoded = try? JSONEncoder().encode(habitDataArray) {
            UserDefaults.standard.set(encoded, forKey: "habits")
        }
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }

    func updateHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = habit
            saveHabits()
        }
    }

    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
        saveHabits()
    }

    // Other methods...
}
