//
//  Habit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

struct HabitHistory: Codable, Hashable {
    static func == (lhs: HabitHistory, rhs: HabitHistory) -> Bool {
        return lhs.unique_id == rhs.unique_id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(unique_id)
    }
    
    var unique_id: UUID = UUID()
    var history: [HabitData] = [] // should have one entry when initialized
    var lastUpdated: Date = Date()

    mutating func addHabit(habit: HabitData) {
        self.history.append(habit)
        self.lastUpdated = Date()
    }

    func getTodaysHabitData() -> HabitData {
        return history.last!
    }
    
    func getTodaysHabit() -> Habit? {
        return Habit.fromHabitData(history.last!)
    }
}

struct HabitData: Codable, Hashable {
    static func == (lhs: HabitData, rhs: HabitData) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(habitType: HabitType, name: String, id: UUID, creationDate: Date, progress: Int? = nil, goal: Int? = nil, region: GeofenceRegion? = nil, completed: Bool? = nil) {
        self.habitType = habitType
        self.name = name
        self.id = id
        self.creationDate = creationDate
        self.progress = progress
        self.goal = goal
        self.region = region
        self.completed = completed
        
        print("Receiving \(id)")
    }
    
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
    
    // TODO: Last updated, so if we're past that, delete it and save into history
    
    func getProgressString() -> String { return "Invalid" }
    func actionButtonClicked() {}
    
    init(name: String, id: UUID = UUID(), creationDate: Date = Date(), activeDays: Set<Weekday> = [], habitHistory: [HabitData] = []) {
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
        switch data.habitType {
        case .habit:
            return Habit(name: data.name, id: data.id, creationDate: data.creationDate)
        case .countHabit:
            return CountHabit(name: data.name, id: data.id, creationDate: data.creationDate, goal: data.goal!)
        case .geofencedCountHabit:
            return GeofencedCountHabit(name: data.name, id: data.id, creationDate: data.creationDate, region: data.region!, goal: data.goal!)
        case .timedHabit: // TODO: Actually do
            return Habit(name: data.name, id: data.id, creationDate: data.creationDate)
        case .geofencedTimeHabit:
            return Habit(name: data.name, id: data.id, creationDate: data.creationDate)
        }
    }
}

enum HabitType: Int, CaseIterable, Codable {
    case habit = 1, countHabit, timedHabit, geofencedCountHabit, geofencedTimeHabit
    
    var name: String {
        switch self {
        case .habit: return "Habit"
        case .countHabit: return "Counting Habit"
        case .timedHabit: return "Timed Habit"
        case .geofencedCountHabit: return "Location Counting Habit"
        case .geofencedTimeHabit: return "Timed Geofencing Habit"
        default:
            return "Unkown habit"
        }
    }
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
