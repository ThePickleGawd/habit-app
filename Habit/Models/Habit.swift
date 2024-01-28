//
//  Habit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

class Habit: Hashable, ObservableObject {
    var id = UUID()
    var creationDate = Date()
    var name: String = ""
    
    func getProgressString() -> String { return "Invalid" }
    func actionButtonClicked() {}
    
    init(id: UUID = UUID(), creationDate: Date = Date(), name: String) {
        self.id = id
        self.creationDate = creationDate
        self.name = name
    }
    
    // Hashing
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
