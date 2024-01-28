//
//  Habit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

struct HabitData: Codable {
    var habitType: HabitType
    
    // Habit
    var name: String
    var id: UUID
    var creationDate: Date
    
    // CountHabit
    var progress: Int?
    var goal: Int?
    
    // GeofencedHabit
    var region: GeofenceRegion?
    var completed: Bool?
    
}

class Habit: Hashable, ObservableObject {
    var name: String = ""
    var id = UUID()
    var creationDate = Date()
    var activeDays: Set<Weekday> = []
    
    func getProgressString() -> String { return "Invalid" }
    func actionButtonClicked() {}
    
    init(name: String, id: UUID = UUID(),creationDate: Date = Date(), activeDays: Set<Weekday> = []) {
        self.id = id
        self.creationDate = creationDate
        self.name = name
        self.activeDays = activeDays
    }
    
    // Hashing
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func toHabitData() -> HabitData {
        return HabitData(habitType: .habit, name: name, id: id, creationDate: creationDate)
    }

    static func fromHabitData(_ data: HabitData) -> Habit {
        return Habit(name: data.name, id: data.id, creationDate: data.creationDate)
    }
}

enum HabitType: Int, Codable {
    case habit = 1, countHabit, geofencedHabit
}

enum Weekday: Int, CaseIterable {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

    var shortName: String {
        switch self {
        case .sunday: return "S"
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "T"
        case .friday: return "F"
        case .saturday: return "S"
        }
    }
}
