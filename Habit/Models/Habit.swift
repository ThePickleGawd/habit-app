//
//  Habit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

class Habit: Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var creationDate: Date
    @Published var history: [HabitHistoryEntry] = []

    init(title: String, creationDate: Date = Date()) {
        self.title = title
        self.creationDate = creationDate
    }

    func addHistoryEntry(_ entry: HabitHistoryEntry) {
        history.append(entry)
    }
}
