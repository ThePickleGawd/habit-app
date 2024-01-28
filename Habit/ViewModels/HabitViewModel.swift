//
//  HabitViewModel.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habitHistorys: [HabitHistory] = []

    init() {
        loadHabitHistorys()
    }

    func loadHabitHistorys() {
        if let historyData = UserDefaults.standard.data(forKey: "habitHistorys"),
           let savedHabitHistory = try? JSONDecoder().decode([HabitHistory].self, from: historyData) {
            self.habitHistorys = savedHabitHistory.map { history in
                print("Loading \(history.getTodaysHabit()!.id)")
                return history
            }
        }
    }
    
    func saveHabitHistorys() {
        if let encoded = try? JSONEncoder().encode(habitHistorys) {
            UserDefaults.standard.set(encoded, forKey: "habitHistorys")
        }
    }

    func addHabit(_ habit: Habit) {
        var history = HabitHistory()
        history.addHabit(habit: habit.toHabitData())
        habitHistorys.append(history)
        saveHabitHistorys()
    }

    func updateHabit(_ habit: Habit) {
        if let index = habitHistorys.firstIndex(where: { $0.getTodaysHabitData().id == habit.id }) {
            habitHistorys[index].history[habitHistorys.count - 1] = habit.toHabitData()
            saveHabitHistorys()
        }
    }

    func deleteHabit(_ habit: Habit) {
        habitHistorys.removeAll { $0.getTodaysHabitData().id == habit.id }
        saveHabitHistorys()
    }

    // Other methods...
}
