//
//  HabitViewModel.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import SwiftUI


class HabitViewModel: ObservableObject {
    // Published property to update views automatically when habits change
    @Published var habits: [Habit] = []

    init() {
        loadHabits()
    }

    func loadHabits() {
        // Load habits from persistent storage
        // This is just a placeholder logic, replace with actual data fetching
        self.habits = [
            CountHabit(name: "Basketball", goal: 1),
            CountHabit(name: "Drink Water", goal: 8),
            CountHabit(name: "Gym", goal: 1)
            // Add more sample habits
        ]
    }

    func addHabit(_ habit: Habit) {
        // Logic to add a new habit
        // Replace with actual implementation
        habits.append(habit)
    }

    func updateHabit(_ habit: Habit) {
        // Logic to update an existing habit
        // Replace with actual implementation
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = habit
        }
    }

    func deleteHabit(_ habit: Habit) {
        // Logic to delete a habit
        // Replace with actual implementation
        habits.removeAll { $0.id == habit.id }
    }

    // Add other methods for additional functionalities
}

